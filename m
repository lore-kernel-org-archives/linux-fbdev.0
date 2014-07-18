From: "John W. Linville" <linville@tuxdriver.com>
Date: Fri, 18 Jul 2014 16:22:13 +0000
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
Message-Id: <20140718162213.GC31114@tuxdriver.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
In-Reply-To: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benoit Taine <benoit.taine@lip6.fr>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ath5k-devel@venema.h4ckr.net, MPT-FusionLinux.pdl@avagotech.com, linux-acenic@sunsite.dk, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, ath10k@lists.infradead.org, linux-hippi@sunsite.dk, industrypack-devel@lists.sourceforge.net, linux-mmc@vger.kernel.org, virtualization@lists.linux-foundation.org, ath9k-devel@venema.h4ckr.net, wil6210@qca.qualcomm.com, linux-pcmcia@lists.infradead.org, linux-can@vger.kernel.org, xen-devel@lists.xenproject.org, platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com, e1000-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org, devel@linuxdriverproject.org

On Fri, Jul 18, 2014 at 05:26:47PM +0200, Benoit Taine wrote:
> We should prefer `const struct pci_device_id` over
> `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> This issue was reported by checkpatch.

Honestly, I prefer the macro -- it stands-out more.  Maybe the style
guidelines and/or checkpatch should change instead?

John
-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
