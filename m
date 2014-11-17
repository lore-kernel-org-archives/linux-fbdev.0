From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 17 Nov 2014 15:37:03 +0000
Subject: [PATCH v2 0/2] dt-bindings: simplefb: Drop the advice about using a specific path for nodes
Message-Id: <1416238625-28590-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

Here is v2 of my patch set to slightly tweak the simplefb bindings wrt
the interface between the boot-loader and the devicetree for pre-populated
simplefb nodes.

Changes in v2: Changed the simplefb-sunxi bindings to use a single
sunxi,pipeline string property instead of a sunxi,pipeline int and a
sunxi,output string property.

This patch set is all acked up, and a fix to the binding changes you've
already queued for 3.19, so please queue these 2 patches for 3.19.

Thanks & Regards,

Hans
