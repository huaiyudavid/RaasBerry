import re
import sys

def parse_cmu(cmufh):
	"""Parses an incoming file handle as a CMU pronouncing dictionary file.
		Returns a list of 2-tuples pairing a word with its phones (as a string)"""
	pronunciations = list()
	for line in cmufh:
		line = line.strip()
		if line.startswith(';'): continue
		word, phones = line.split("  ")
		word = re.sub(r'\(\d\)$', '', word.lower())
		phones_list = phones.split(" ")
		pronunciations.append((word.lower(), phones))
	return pronunciations 

pronunciations = parse_cmu(open('cmudict'))

def syllable_count(phones):
	return sum([phones.count(i) for i in '012'])

def phones_for_word(find):
	"""Searches a list of 2-tuples (as returned from parse_cmu) for the given
		word. Returns a list of phone strings that correspond to that word."""
	matches = list()
	for word, phones in pronunciations:
		if word == find:
			matches.append(phones)
	return matches

def rhyming_part(phones):
	"""Returns the "rhyming part" of a string with phones. "Rhyming part" here
		means everything from the vowel in the stressed syllable nearest the end
		of the word up to the end of the word."""
	idx = 0
	phones_list = phones.split()
	for i in reversed(range(0, len(phones_list))):
		if phones_list[i][-1] in ('1', '2'):
			idx = i
			break
	return ' '.join(phones_list[idx:])

def search(pattern):
	"""Searches a list of 2-tuples (as returned from parse_cmu) for
		pronunciations matching a given regular expression. (Word boundary anchors
		are automatically added before and after the pattern.) Returns a list of
		matching words."""
	matches = list()
	for word, phones in pronunciations:
		if re.search(r"\b" + pattern + r"\b", phones):
			matches.append(word)
	return matches

def rhymes(word):
	"""Searches a list of 2-tuples (as returned from parse_cmu) for words that
		rhyme with the given word. Returns a list of such words."""
	all_rhymes = list()
	all_phones = phones_for_word(word)
	for phones_str in all_phones:
		part = rhyming_part(phones_str)
		rhymes = search(part + "$")
		all_rhymes.extend(rhymes)
	return [r for r in all_rhymes if r != word]

def rhyme_class(word):
	all_phones = phones_for_word(word)
	return [rhyming_part(phones_str) for phones_str in all_phones]

if __name__ == '__main__':
    word = sys.argv[1]
    print(rhymes(word))

