From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Current discussion about the future of free software graphics
Date: Wed, 12 May 2004 15:14:23 +0100
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <1084371262.26224.11.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0405112050570.17349-100000@phoenix.infradead.org>
Reply-To: dri-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0405112050570.17349-100000@phoenix.infradead.org>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: DRI Devel <dri-devel@lists.sourceforge.net>
Cc: sottek <sottek@sottekland.com>, eich@pdx.freedesktop.org, agd5f@yahoo.com, michel@daenzer.net, keithp@keithp.com, jonsmirl@yahoo.com, linux-fbdev-devel@lists.sourceforge.net

On Maw, 2004-05-11 at 20:55, James Simmons wrote:
> Ug. I see I'm fighting a losing battle but it doesn't matter. I couldn't 
> never win this fight. There is MONEY involved here. This is a sure way
> to make sure Tungstengraphics has a income coming in. They want a monoply 
> on the linux graphics arena then fine they can have it. 

Current DRI is certainly a PITA unless you know it well but the kernel
side is quite trivial underneath the macrotrastrophe and preprocessor
abuse. 

Its mappable buffers, queue, interrupt handler, X<->kernel auth mapping,
and thats it

Also I'd note several folks are doing DRI nowday without Tungsten - VIA
did the Savage and VIA drivers, sis6326 is a WIP but its also not
tungsten stuff.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
--
