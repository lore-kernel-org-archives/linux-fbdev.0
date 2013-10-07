From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 07 Oct 2013 06:50:33 +0000
Subject: Re: [PATCH 1/2] hyperv-fb: add pci stub
Message-Id: <1381128633.13574.3.camel@nilsson.home.kraxel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
	 <465ef0cb45e04bcc94c4788c0d930c4d@SN2PR03MB061.namprd03.prod.outlook.com>
In-Reply-To: <465ef0cb45e04bcc94c4788c0d930c4d@SN2PR03MB061.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: KY Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mi, 2013-10-02 at 14:29 +0000, KY Srinivasan wrote:
> 
> > This patch adds a pci stub driver to hyper-fb.  The hyperv framebuffer
> > driver will bind to the pci device then, so linux kernel and userspace
> > know there is a proper kernel driver for the device active.  lspci shows
> > this for example:

> Gerd,
> 
> Thanks for doing this. This certainly will address some of the issues that are reported. I do have a question though - how would this work if we don't have PCI bus in the guest.

The hyperv framebuffer driver wouldn't work in the first place then as
it looks up the framebuffer address in pci config space (see hvfb_getmem
function).

cheers,
  Gerd



