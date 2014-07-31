From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 31 Jul 2014 10:11:41 +0000
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <EE124450C0AAF944A40DD71E61F878C98F6F78@SINEX14MBXC417.southpacific.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404875063-27424-1-git-send-email-decui@microsoft.com>
 <53D90008.4060908@ti.com>
In-Reply-To: <53D90008.4060908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: Wednesday, July 30, 2014 22:24 PM
> > +static struct fb_info *hvfb_info;
> 
> Static variables like these are usually a no-no. This prevents you from
> having multiple device instances.
I agree.

> >  static uint screen_width = HVFB_WIDTH;
> >  static uint screen_height = HVFB_HEIGHT;
> >  static uint screen_depth;
> >  static uint screen_fb_size;
> >
> > +/* If true, the VSC notifies the VSP on every framebuffer change */
> > +static bool synchronous_fb;
> > +
> 
> Same comment here.
> 
> However, if (and only if) the driver is already designed to work only
> with single device instance, then this patch is probably ok. But even
IMO the host should only provide at most 1 synthetic video device to a VM. :-)

> then, I'd prefer this to be handled without static variables so that the
> driver could eventually be changed to support multiple device instances.

Hi Tomi,
Maybe we can remove these static stuff:
+static struct fb_info *hvfb_info;
+static struct notifier_block hvfb_panic_nb = {
+	.notifier_call = hvfb_on_panic,
+};
by kmalloc()-ing  a new struct:
struct hv_fb_panic_nb {
        struct fb_info *hvfb_info;
        struct notifier_block nb;
}
?
I think in hvfb_on_panic() we should be able to get the
hvfb_info pointer by
hvfb_info = container_of(nb, struct hv_fb_panic_nb, nb).

If you like that or have a better idea, please let me know so
I can make a new patch.

Thanks,
-- Dexuan
