From: Dexuan Cui <decui@microsoft.com>
Date: Tue, 08 Jul 2014 22:17:48 +0000
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <EE124450C0AAF944A40DD71E61F878C987A663@SINEX14MBXC417.southpacific.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403818501-15547-1-git-send-email-decui@microsoft.com>
 <20140708092709.GI25880@mwanda>
In-Reply-To: <20140708092709.GI25880@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Haiyang Zhang <haiyangz@microsoft.com>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, July 8, 2014 17:27 PM
> To: Dexuan Cui
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; driverdev-
> devel@linuxdriverproject.org; plagnioj@jcrosoft.com;
> tomi.valkeinen@ti.com; linux-fbdev@vger.kernel.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; Haiyang Zhang
> Subject: Re: [PATCH v2] video: hyperv: hyperv_fb: refresh the VM screen by
> force on VM panic
> 
> Don't use likely/unlikely unless you have benchmark numbers to show that
> it makes a speed up.
> 
> regards,
> dan carpenter

Hi Dan,
Here the variable 'synchronous_fb' is only set to true when the system panics.
So before the system panics, it's always 'unlikely'. :-)

Thanks,
-- Dexuan
