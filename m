From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 17 Apr 2019 21:28:08 +0000
Subject: Re: [PATCH v3 14/26] compat_ioctl: move ATYFB_CLK handling to atyfb driver
Message-Id: <20190417212808.GA2217@ZenIV.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
 <20190416202701.127745-3-arnd@arndb.de>
 <20190417212700.GZ2217@ZenIV.linux.org.uk>
In-Reply-To: <20190417212700.GZ2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mikulas Patocka <mpatocka@redhat.com>, "David S. Miller" <davem@davemloft.net>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Wed, Apr 17, 2019 at 10:27:00PM +0100, Al Viro wrote:
> On Tue, Apr 16, 2019 at 10:25:35PM +0200, Arnd Bergmann wrote:
> > +static int atyfb_compat_ioctl(struct fb_info *info, u_int cmd, u_long arg)
> > +{
> > +	return atyfb_ioctl(info, cmd, (u_long)compat_ptr(arg));
> > +}
> > +#endif
> 
> Huh?  Why isn't that using compat_ioctl_ptr()?

Oh, I see...  Nevermind, then.
