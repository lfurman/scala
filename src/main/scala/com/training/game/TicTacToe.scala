package com.training.game

import java.awt.Color

import scala.swing._
import scala.swing.event.{ButtonClicked, Event}
/**
 * Created by: Leonid Furman
 * Date:       9/18/15.
 */
case class PlayEvent(button: AbstractButton, row: Int, col: Int) extends Event

case class GamePanel(override val rows: Int, cols: Int) extends GridPanel(rows, cols) with Publisher {
  def reset() = buttons.foreach(
    row => row.foreach(
      button => {
        button.enabled = true
        button.text = ""
      }
    )
  )

  val winnerLines = List(
    ((0, 0), (0, 1), (0, 2)),
    ((1, 0), (1, 1), (1, 2)),
    ((2, 0), (2, 2), (2, 2)),
    ((0, 1), (1, 1), (2, 1)),
    ((0, 2), (1, 2), (2, 2)),
    ((0, 0), (1, 1), (2, 2)),
    ((0, 2), (1, 1), (2, 0))
  )

  def isWin: Boolean = {
    winnerLines.exists(
      winnerLine => {
        !buttons(winnerLine._1._1)(winnerLine._1._2).enabled &&
        !buttons(winnerLine._2._1)(winnerLine._2._2).enabled &&
        !buttons(winnerLine._3._1)(winnerLine._3._2).enabled &&
        buttons(winnerLine._1._1)(winnerLine._1._2).text == buttons(winnerLine._2._1)(winnerLine._2._2).text &&
        buttons(winnerLine._2._1)(winnerLine._2._2).text == buttons(winnerLine._3._1)(winnerLine._3._2).text
      }
    )
  }

  border = Swing.EmptyBorder(30, 30, 10, 30)
  background = Color.GRAY

  val buttons = Array.tabulate(rows, cols)(
    (row, col) => {
      val button = new Button
      listenTo(button)
      contents += button
      button.reactions += {
        case ButtonClicked(b) => publish(PlayEvent(b, row, col))
      }
      button
    }
  )
}

object TicTacToe extends SimpleSwingApplication with Publisher {
  override def top: Frame = new MainFrame {
    title = "Tic Tac Toe"

    var nClicks: Int = 0
    val gamePanel = new GamePanel(3, 3)
    listenTo(gamePanel)
    contents = gamePanel

    reactions += {
      case PlayEvent(button, row, col) =>
        nClicks += 1
        val playerId = getPlayerId(nClicks)
        updatePosition(playerId, button)
        evaluatePosition(playerId)
    }

    def getPlayerId(nClicks: Int): String = {
      nClicks % 2 match {
        case 1 => "X"
        case _ => "0"
      }
    }

    def updatePosition(playerId: String, button: AbstractButton): Unit = {
      button.enabled = false
      button.text = playerId
    }

    def evaluatePosition(playerId: String): Unit = {
      gamePanel.isWin match {
        case true =>
          Dialog.showMessage(null, "Player " + playerId + " won", "Notification")
          gamePanel.reset()
          nClicks = 0
        case _ =>
          nClicks match {
            case 9 =>
              Dialog.showMessage(null, "Game over", "Notification")
              gamePanel.reset()
              nClicks = 0
            case _ =>
          }
      }
    }
  }
}
