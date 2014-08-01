From: Dexuan Cui <decui@microsoft.com>
Date: Fri, 01 Aug 2014 10:22:53 +0000
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <EE124450C0AAF944A40DD71E61F878C98FBD6A@SINEX14MBXC417.southpacific.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404875063-27424-1-git-send-email-decui@microsoft.com>
 <53D90008.4060908@ti.com>
 <EE124450C0AAF944A40DD71E61F878C98F6F78@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <53DA46C3.9080905@ti.com>
In-Reply-To: <53DA46C3.9080905@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: Thursday, July 31, 2014 21:38 PM
> > I think in hvfb_on_panic() we should be able to get the
> > hvfb_info pointer by
> > hvfb_info = container_of(nb, struct hv_fb_panic_nb, nb).
> >
> > If you like that or have a better idea, please let me know so
> > I can make a new patch.
> 
> Or maybe you can add the notifier_block and the synchronous_fb to
> hvfb_par? From the notifier_block pointer you could then get hvfp_par,
> and from there hvfb_info.
>  Tomi

Hi Tomi,
Thanks a lot for the suggestion! It's better.
I'll send out a v4 patch for your review.

Thanks,
-- Dexuan

