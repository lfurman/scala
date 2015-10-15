package com.training.functions

import scala.io.Source

/**
 * Created by: Leonid Furman
 * Date:       10/7/15.
 */
trait Censor {

  val wordsMap = loadWordsMap("curseWords.txt")

  def loadWordsMap(filePath: String) = {
    Source.fromFile(filePath).getLines().foldLeft(Map.empty[String, String])((wordsMap, line) => {
        val wordPair = line.split("\\s+")
        wordsMap + (wordPair(0) -> wordPair(1))
      }
    )
  }

  def replaceWords(words: List[String]): List[String] = {
    words.map(word => wordsMap.getOrElse(word, word))
  }
}

object CensorTest extends App with Censor{

  val words = List("Shoot", "Hello", "Darn", "World")
  println(s"""Replaced words: ${replaceWords(words)}""")
}