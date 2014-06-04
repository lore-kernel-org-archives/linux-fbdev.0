From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 04 Jun 2014 09:07:50 +0000
Subject: [PATCH 0/10] use safer test on the result of find_first_zero_bit
Message-Id: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rdma@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-scsi@vger.kernel.org, iss_storagedev@hp.com, linux-sh@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, ath10k@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, netdev@vger.kernel.org

Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
return a larger number than the maximum position argument if that position
is not a multiple of BITS_PER_LONG.

