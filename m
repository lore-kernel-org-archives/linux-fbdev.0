From: Alex Thiel <stderr@web.de>
Subject: Re: Neomagic fb driver oopses with linux 2.5
Date: Sat, 26 Jul 2003 20:25:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m3smotno1o.fsf@spock.alex.net>
References: <Pine.LNX.4.44.0307250050320.7845-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307250050320.7845-100000@phoenix.infradead.org> (James
 Simmons's message of "Fri, 25 Jul 2003 00:51:53 +0100 (BST)")
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

>> The machine is a Sony Vaio PCG-505FX, lspci reports the graphic chip as
>> 00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01)
>
> My new laptop is a NeoMagic again so I can test it out.
>  
>> Kernel is 2.5.75 compiled with gcc 2.95.4. Here is the decoded oops,
>> this one is with the patches applied.

[oops ommited]

>
> I did a assembly dump of my cfbimgblt.o and I couldn't match the code up.
> Strange I can't figure it out. I will try turning of hardware accel on 
> mine.

I noticed that ksymoops complained about not being able to open
/proc/ksyms which seems to have gone in 2.5. Can this cause a
misinterpretation of the raw oops data?

Anyway, I managed to connect to the laptop via a serial line and hope
to be able to track down the problem a little more this way.

Cheers,

        Alex




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
