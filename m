From: Linus WALLEIJ <linus.walleij@stericsson.com>
Date: Tue, 04 May 2010 14:41:30 +0000
Subject: Documentation in Documentation/DocBook
Message-Id: <CEE6BB42CAD6E947908279175AF8470A025A636CED@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

we're developing a framebuffer driver for the
ST-Ericsson U8500.

We really like formatted documentation so we put
that in DocBook format in Documentation/DocBook/*.
This has the upside that it's easy to include
Kerneldoc headers etc into the documentation.

However most of the FB documentation up to now
is in Documentation/fb/*.

What is best for the FB subsystem: some nice
Kerneldoc or a regular textfile?

Yours,
Linus Walleij
ST-Ericsson SA
