From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 7 May 2004 00:20:27 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405062111460.20402-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0405062141170.20729@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0405062141170.20729@waterleaf.sonytel.be>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> > Another topic that I missed was, why did kgi fail and what can we do to avoid
> > repeating the same path this time around.
> 
> IIRC, the main reasons were:
>   - GGI wanted to do too much at once and was too intruisive (conclusion:
>     always advance in small steps, not big leaps):
>       o kernel graphics drivers (KGI)
>       o new input subsystem (similar to what we're heading to now)
>       o user space library (libggi, AFAIK the only part that's still alive)
>   - fbdev was better in multi-platform handling (m68k -> PPC -> ia32 -> SPARC
>     -> alpha -> ...)
> 
> Please correct me if I'm wrong ;-)

The KGI is way to complex. I attempted to write a driver using that system 
but I was totally lost. Fbdev, especially now is much easier to develope.
The input system we have is very similiar to what they had. I'm really 
glad we have a input system. As for the library. Well it has always been 
a dream to have a universal library by many people. It never happened and 
never will happen. When it comes it libraries you have issues like 
licenses and people fighting 




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
