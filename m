From: Shawn Guo <shawn.guo@linaro.org>
Date: Fri, 04 Jan 2013 07:42:21 +0000
Subject: Re: [BUGFIX PATCH] video: mxsfb: fix crash when unblanking the display
Message-Id: <20130104074219.GD1887@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
 <20663.19785.221750.909491@ipc1.ka-ro>
 <50E67FDC.3000905@bluegiga.com>
In-Reply-To: <50E67FDC.3000905@bluegiga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 04, 2013 at 09:08:12AM +0200, Lauri Hintsala wrote:
> On 11/29/2012 01:55 PM, Lothar Wa=DFmann wrote:
> >Hi,
> >
> >adding Juergen Beisert as the driver's author to the recipient list.
> >
> >Lothar Wa=DFmann writes:
> >>The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
> >>The write in mxsfb_disable_controller() sets the data_cnt for the LCD
> >>DMA to 0 which obviously means the max. count for the LCD DMA and
> >>leads to overwriting arbitrary memory when the display is unblanked.
> >>
> >>Note: I already sent this patch in December 2011 but noone picked it up=
 obviously.
> >>
> >>Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
>=20
> Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.net>
>=20
> This fixes the CPU freezing. I really recommend to apply this patch
> into mainline soon because unblanking freezes the whole system!!!
>=20
> Default value of consoleblank parameter is 600 seconds and the whole
> system crashes every time when framebuffer console is activated
> after that timeout. I wonder why this issue is still open in
> mainline kernel.

Part of the reason is the FB maintainer's absence.  Let me try to send
it through arm-soc tree.

>=20
> Should this patch be added into stable versions too?
>=20
Yes, will do.

Shawn

