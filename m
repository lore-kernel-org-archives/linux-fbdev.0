From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 19 Aug 2013 11:20:34 +0000
Subject: [PATCH 0/7] replace devm_request_and_ioremap by devm_ioremap_resource
Message-Id: <1376911241-27720-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

devm_request_and_ioremap has been replaced by devm_ioremap_resource, which
gives more informative error return code information.  This patch series
removes the remaining uses of devm_request_and_ioremap.

This patch series was generated using the semantic patch
scripts/coccinelle/api/devm_ioremap_resource.cocci from the Linux kernel
source tree.  Manual modifications have been made to move associated calls
to platform_get_resource closer to the resulting call to
devm_ioremap_resource and to remove the associated error handling code.

