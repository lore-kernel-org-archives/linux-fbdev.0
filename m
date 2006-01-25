From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Issue with clgenfb module
Date: Wed, 25 Jan 2006 22:06:04 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0601252205090.24270@pademelon.sonytel.be>
References: <yam10251.1290.139074696@smtp.pop.debitel.net>
Mime-Version: 1.0
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
Sender: geert@sonycom.com
In-Reply-To: <yam10251.1290.139074696@smtp.pop.debitel.net>
Resent-Message-ID: <I0SSbD.A.c3F.Ph-1DB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Krummrich <peter.krummrich@debitel.net>
Cc: Debian GNU/Linux m68k <debian-68k@lists.debian.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 25 Jan 2006, Peter Krummrich wrote:
> in my set-up (Amiga2000, PicassoII graphics adapter), there is an issue with
> the display. In low resolution modes (640x460), there are some flickering
> pixels. Many more of them occur, if I switch to higher resolution modes
> (1024x768). Scrolling really results in a mess on the display in these
> modes.
> 
> When looking at the code of clgenfb, I found that the value for the display
> memory clock MCLK is calculated depending on the value of the video pixel
> clock VCLK. According to the video adapter chip (Cirrus Logic GD5426)
> manual, MCLK should be set depending on video memory speed, i. e.
> regardless of VCLK. If MCLK is calculated depending on VCLK, the memory
> interface can be overclocked for higher resolution modes.
> 
> Is someone who used to work on clgenfb code still around? I would like to
> discuss this issue with him and try to come up with code that avoids the
> display problems with my Picasso board.

Maybe someone on linux-fbdev-devel@lists.sourceforge.net can help?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
