From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 21:46:33 +0200 (MEST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405062141170.20729@waterleaf.sonytel.be>
References: <20040506181639.61975.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040506181639.61975.qmail@web14929.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 6 May 2004, Jon Smirl wrote:
> Another topic that I missed was, why did kgi fail and what can we do to avoid
> repeating the same path this time around.

IIRC, the main reasons were:
  - GGI wanted to do too much at once and was too intruisive (conclusion:
    always advance in small steps, not big leaps):
      o kernel graphics drivers (KGI)
      o new input subsystem (similar to what we're heading to now)
      o user space library (libggi, AFAIK the only part that's still alive)
  - fbdev was better in multi-platform handling (m68k -> PPC -> ia32 -> SPARC
    -> alpha -> ...)

Please correct me if I'm wrong ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
