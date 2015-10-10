From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 10 Oct 2015 12:30:50 +0000
Subject: [PATCH 1/5] backlight: 88pm860x_bl: add missing of_node_put
Message-Id: <1444480254-14399-2-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/backlight/88pm860x_bl.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
index 2da5862..6d8dc2c 100644
--- a/drivers/video/backlight/88pm860x_bl.c
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -180,6 +180,7 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
 			data->iset = PM8606_WLED_CURRENT(iset);
 			of_property_read_u32(np, "marvell,88pm860x-pwm",
 					     &data->pwm);
+			of_node_put(np);
 			break;
 		}
 	}

