From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 16:09:15 +0000
Subject: Re: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <alpine.LFD.2.00.1007061708330.3285@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-259633175-1278432556=:3285"
List-Id: <linux-fbdev.vger.kernel.org>
References: <25797910.38561278057053699.JavaMail.weblogic@epml17>
In-Reply-To: <25797910.38561278057053699.JavaMail.weblogic@epml17>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-259633175-1278432556=:3285
Content-Type: TEXT/PLAIN; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


>=20
> I think this issue incompatible with existing users is because userspace =
API didn't consider cpu mode before.
> anyway, I will correct my patch as your comments and send it again.
> Perhaps, cpu timing variables would be moved to platform file.

I would suggest using sysfs for those extra variables.

> thank you.
>=20
> ------- Original Message -------
> Sender : Russell King - ARM Linux<linux@arm.linux.org.uk>=20
> Date   : 2010-07-02 16:30 (GMT+09:00)
> Title  : Re: [PATCH 1/3] FB: Add some members for CPU Interface.
>=20
> On Wed, Jun 30, 2010 at 08:02:31AM +0800, Jaya Kumar wrote:
> > > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > > index 907ace3..73381c3 100644
> > > --- a/include/linux/fb.h
> > > +++ b/include/linux/fb.h
> > > @@ -269,6 +269,12 @@ struct fb_var_screeninfo {
> > >  	__u32 vmode;			/* see FB_VMODE_*		*/
> > >  	__u32 rotate;			/* angle we rotate counter clockwise */
> > >  	__u32 reserved[5];		/* Reserved for future compatibility */
> > > +
> > > +	/* For cpu interface timing. */
> > > +	__u32 cs_setup;
> > > +	__u32 wr_setup;
> > > +	__u32 wr_act;
> > > +	__u32 wr_hold;
>=20
> This changes the framebuffer userspace API, making it incompatible with
> existing users.  What this means is that stuff using the framebuffer API
> in userspace has to be upgraded/downgraded in lock-step with this change
> - which is not a good idea.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{.n=
=C7+=89=B7=A5=8A{=B1}=B7^=BE)=ED=85=E6=E8w*=1Fjg=AC=B1=A8=1E=B6=89=9A=8E=8A=
=DD=A2j/???=EA=E4z=B9=DE=96=8A=E02=8A=DE=99=A8=E8=AD=DA&=A2)=DF=A1=ABa=B6=
=DA=7F=FE=F8=1E=AEG=AB???=E9h=AE=0F=E6j:+v=89=A8=8Aw=E8=86=D9=A5
--1985284609-259633175-1278432556=:3285--
