From: James Simmons <jsimmons@infradead.org>
Subject: timer question?
Date: Wed, 25 Jun 2003 17:31:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0306251722470.26713-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Currently the framebuffer console initializes one timer to flash the 
cursor. In the timer function we call schedule_work. I like to support 
more than one cursor, one for each framebuffer. Now the question is which 
is better to do?

1) To use one timer and go threw all the framebuffer devices pushing data 
   threw schedule_work for each one.

2) Create a seperate timer for each framebuffer.
