From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 17 Nov 2014 11:34:44 +0000
Subject: [PATCH 0/2] dt-bindings: simplefb: Drop the advice about using a specific path for nodes
Message-Id: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi All,

Review of the u-boot sunxi simplefb patches has lead to the decision that
u-boot should not use a specific path to find the nodes as this goes contrary
to how devicetree usually works.

Instead a platform specific compatible + properties should be used for this.

This series updates the simplefb bindings reflect this.

Regards,

Hans
