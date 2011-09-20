From: Baruch Siach <baruch@tkos.co.il>
Date: Tue, 20 Sep 2011 17:08:59 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning
Message-Id: <20110920170858.GA3827@tarshish>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<20110920112427.GB19695@sapphire.tkos.co.il>
	<CAEC9eQOpwfmRfcxHoiA00xX0a=dxXj1xJDpW14DozGXKXPJ3Xg@mail.gmail.com>
In-Reply-To: <CAEC9eQOpwfmRfcxHoiA00xX0a=dxXj1xJDpW14DozGXKXPJ3Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Ajay,

On Tue, Sep 20, 2011 at 08:56:57PM +0530, Ajay kumar wrote:
> Hi Baruch,
> On Tue, Sep 20, 2011 at 4:54 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > Hi Ajay,
> >
> > On Tue, Sep 20, 2011 at 11:30:39AM -0400, Ajay Kumar wrote:
> >> This patch adds a data structure definiton to hold framebuffer windows=
/planes.
> >> An ioctl number is also added to provide user access
> >> to change window position dynamically.
> >
> > [snip]
> >
> >> +/* Window overlaying */
> >> +struct fb_overlay_win_pos {
> >> + =A0 =A0 __u32 win_pos_x; =A0 =A0 =A0 =A0/* x-offset from LCD(0,0) wh=
ere window starts */
> >> + =A0 =A0 __u32 win_pos_y; =A0 =A0 =A0 =A0/* y-offset from LCD(0,0) wh=
ere window starts */
> >> +};
> >
> > Why not allow negative offsets where the left or upper part of the fram=
ebuffer
> > is hidden?
>=20
> Thanks for pointing it out. Are there drivers which place the overlay
> windows such that some part of the window is hidden from being
> displayed on the screen?

I don't know. However, since this is new userspace ABI which should stay=20
compatible forever, we should make sure to do it right. Using __s32 instead=
 of=20
__u32 won't limit us in the future.

baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
