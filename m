From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Wed, 26 Feb 2014 15:43:41 +0000
Subject: RE: [PATCH v5 2/2] hyperv-fb: kick off efifb early
Message-Id: <7f41262bad3c4043bded61abc759dac7@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393411885-14895-1-git-send-email-kraxel@redhat.com>
 <1393411885-14895-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393411885-14895-3-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, "Abhishek Gupta (LIS)" <abgupta@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Wednesday, February 26, 2014 5:51 AM
> To: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; gregkh@linuxfoundation.org; KY Srinivasan;
> Abhishek Gupta (LIS); Haiyang Zhang; jasowang@redhat.com;
> tomi.valkeinen@ti.com; devel@linuxdriverproject.org; Gerd Hoffmann; Jean-
> Christophe Plagniol-Villard
> Subject: [PATCH v5 2/2] hyperv-fb: kick off efifb early
> 
> Remove firmware framebuffer before initializing hyperv-fb.  Needed
> on gen2 virtual machines.   Letting register_framebuffer handle the
> switchover results in efifb still being active while hyperv graphics
> are initialized, which in turn can make the linux kernel hang.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Thank you!

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

