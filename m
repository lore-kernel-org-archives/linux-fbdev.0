From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Apr 2011 05:46:02 +0000
Subject: Re: [RFC][PATCH 0/3] MERAM support for LCDC
Message-Id: <BANLkTinoRDza1WKsYdwKTJvumoUaqeYr3g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Damian,

Thanks for your work on this!

On Tue, Mar 29, 2011 at 12:35 PM, Damian Hobson-Garcia
<dhobsong@igel.co.jp> wrote:
> This patch series is based on the fbdev tree.
>
> This series adds support for read-ahead cache access through the ICBs and
> MERAM available on SH devices. =A0The exact ICBs to use are chip specific
> and are specified in the platform data.
>
> Damian Hobson-Garcia (3):
> =A0sh_mobile_meram: MERAM framework for LCDC
> =A0sh_mobile_meram: Add support for NV24 framebuffers
> =A0sh_mobile_meram: MERAM platform data for LCDC

I think these patches look very good in general. I have one request
and some general comments:

Please add Runtime PM support to the MERAM driver. The MSTP113 bit of
SMSTPCR1 should be dynamically controlled using pm_runtime_get_sync()
and pm_runtime_put_sync().

I also wonder if we can chose to use MERAM dynamically somehow. I know
the sh7372 MERAM can be used to back the entire frame buffer memory
(controlled by the LRCTRL register, see the MERAM section in the
sh7372 data sheet). This fully-backed mode can perhaps be used to save
power for regular low-performance operation and/or semi-standby.

For low-performance operation I imagine that by using MERAM for frame
buffer memory we can put the SDRAM in self-refresh mode and that way
enter deep idle modes even though the screen is still operating.

The semi-standby would be that the "real" framebuffer is in say 32-bit
RGB in SDRAM, but we keep a 8-bit RGB shadow buffer in MERAM and
switch to that at the same instant we move from full backlight to low
backlight. This is most likely useful only when combined with
switching the LCD panel itself to 8-bit mode as well to save
bandwidth.

Then you have your full-performance mode that I guess is what these
patches implement. =3D)

Any ideas/suggestions about the low power LCDC modes?

Thanks,

/ magnus
