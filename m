From: Alex Thiel <stderr@web.de>
Subject: Re: Neomagic fb driver oopses with linux 2.5
Date: Tue, 29 Jul 2003 22:14:19 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m34r15ks4k.fsf@spock.alex.net>
References: <Pine.LNX.4.44.0307291811080.5874-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307291811080.5874-100000@phoenix.infradead.org> (James
 Simmons's message of "Tue, 29 Jul 2003 18:14:02 +0100 (BST)")
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@sourceforge.net

James Simmons <jsimmons@infradead.org> writes:

>> I noticed that ksymoops complained about not being able to open
>> /proc/ksyms which seems to have gone in 2.5. Can this cause a
>> misinterpretation of the raw oops data?
>> 
>> Anyway, I managed to connect to the laptop via a serial line and hope
>> to be able to track down the problem a little more this way.
>
> Hm. It has changed again. Anyone know the current method for backtracing.

I have recompiled the kernel with debugging symbols included, and gdb
thinks the oops occurs at line 264 in cfbimgblt.c. I don't know how
accurate this is, though, since this line is in function
fast_imageblit() while the backtrace rather pointed at cfb_imageblit().

                 Alex



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
