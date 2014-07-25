From: Dexuan Cui <decui@microsoft.com>
Date: Fri, 25 Jul 2014 07:15:11 +0000
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <EE124450C0AAF944A40DD71E61F878C98DF851@SINEX14MBXC417.southpacific.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404875063-27424-1-git-send-email-decui@microsoft.com>
 <EE124450C0AAF944A40DD71E61F878C98D83A8@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140724035328.GB7484@kroah.com>
In-Reply-To: <20140724035328.GB7484@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>

> -----Original Message-----
> From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, July 24, 2014 11:53 AM
> > So, hi Greg and all,
> > If you think the patch itself is OK, may I know if it's OK for the patch to go
> > into Greg's char-misc.git tree, as some other hyper-v patches did?
> 
> No, it needs to go through the fb tree, not mine, sorry.
> 
> greg k-h

Hi Greg,
Thank you very much for the clarification!
It's clear to me now.
Let me just wait the framebuffer maintainers' reply. :-)

Thanks,
-- Dexuan
