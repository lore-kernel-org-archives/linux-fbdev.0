From: Olaf Hering <olaf@aepfle.de>
Date: Tue, 19 Feb 2013 18:40:09 +0000
Subject: Re: [PATCH RFC] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <20130219184009.GA21783@aepfle.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360955396-14183-1-git-send-email-haiyangz@microsoft.com>
 <20130219165118.GA17715@aepfle.de>
 <1ca36b5d55c64ac6b8854c4f216ef8e5@DFM-TK5MBX15-06.exchange.corp.microsoft.com>
In-Reply-To: <1ca36b5d55c64ac6b8854c4f216ef8e5@DFM-TK5MBX15-06.exchange.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>

On Tue, Feb 19, Haiyang Zhang wrote:

> The emulated video device is a separate device from the synthetic video.
> The synthetic driver can only take control of the synthetic video, but not
> the emulated video.

Please add this to the comment above.

> Actually, we already have a similar mechanism in ata/ata_piix.c to disable
> emulated IDE drive on Hyper-V, so it won't conflict with the synthetic drive.

I havent read the vesafb code, but I think it can kind of give up the
hardware, something ata_piix can not do.

Olaf
