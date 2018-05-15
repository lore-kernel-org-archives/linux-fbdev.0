From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 15 May 2018 10:26:27 +0000
Subject: Re: [PATCH v2 7/7] media: via-camera: allow build on non-x86 archs with COMPILE_TEST
Message-Id: <1895464.TslDYuHLm1@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1524245455.git.mchehab@s-opensource.com>
        <20180504110701.5436d05c@vento.lan> <33168202.5GZa68eadz@amdc3058>
        <CGME20180515102628eucas1p16f05cb2a1189768f1426b6e5e99aa0a3@eucas1p1.samsung.com>
In-Reply-To: <33168202.5GZa68eadz@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Hans Verkuil <hans.verkuil@cisco.com>, Arnd Bergmann <arnd@arndb.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Jacob Chen <jacob-chen@iotwrt.com>, Bhumika Goyal <bhumirks@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

On Friday, May 04, 2018 04:24:15 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, May 04, 2018 11:07:01 AM Mauro Carvalho Chehab wrote:
> > Em Mon, 23 Apr 2018 14:19:31 +0200
> > Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> escreveu:
> > 
> > 
> > > How's about just allowing COMPILE_TEST for FB_VIA instead of adding
> > > all these stubs?
> > 
> > Works for me.
> > 
> > Do you want to apply it via your tree or via the media one?
> > 
> > If you prefer to apply on yours:
> > 
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> Thanks, I'll apply it to my tree later.

I've queued the patch for v4.18 now.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

