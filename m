From: Randy Dunlap <rdunlap@xenotime.net>
Date: Wed, 05 May 2010 17:48:57 +0000
Subject: Re: Documentation in Documentation/DocBook
Message-Id: <20100505104857.0b018d0e.rdunlap@xenotime.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CEE6BB42CAD6E947908279175AF8470A025A636CED@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A636CED@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 4 May 2010 16:41:30 +0200 Linus WALLEIJ wrote:

> Hi,
> 
> we're developing a framebuffer driver for the
> ST-Ericsson U8500.
> 
> We really like formatted documentation so we put
> that in DocBook format in Documentation/DocBook/*.
> This has the upside that it's easy to include
> Kerneldoc headers etc into the documentation.

Yes, that's a good advantage.

> However most of the FB documentation up to now
> is in Documentation/fb/*.
> 
> What is best for the FB subsystem: some nice
> Kerneldoc or a regular textfile?

Hi,

If the documentation needs pretty formatting, then use docbook.
If plain text is sufficient, then just use that.

In the end, I would just do whichever you are more comfortable with.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
