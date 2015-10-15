package com.training.functions

import scala.io.Source

/**
 * Created by: Leonid Furman
 * Date:       10/4/15.
 */
object FunctionRunner extends App {

  def calculateWordsFromFile(filePath: String): Int = {
    Source.fromFile(filePath).getLines().foldLeft(0)(
      (sum, line) => line.split("\\s+").foldLeft(0)((sum, word) => sum + 1)
    )
  }

  val filePath = "article.txt"
  println(s"""Number of words in file $filePath: ${calculateWordsFromFile(filePath)}""")
}
