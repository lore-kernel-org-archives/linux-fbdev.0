From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 23 Aug 2015 00:11:15 +0000
Subject: [PATCH 04/11] fbdev: ssd1307fb: fix error return code
Message-Id: <1440288682-12732-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Propagate error code on failure.  Also changed %ld to %d in dev_err to use
ret variable rather than putting two calls to PTR_ERR.

A simplified version of the semantic match that finds the first problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/ssd1307fb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3e153c0..1611215 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -656,8 +656,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	bl = backlight_device_register(bl_name, &client->dev, par,
 				       &ssd1307fb_bl_ops, NULL);
 	if (IS_ERR(bl)) {
-		dev_err(&client->dev, "unable to register backlight device: %ld\n",
-			PTR_ERR(bl));
+		ret = PTR_ERR(bl);
+		dev_err(&client->dev, "unable to register backlight device: %d\n",
+			ret);
 		goto bl_init_error;
 	}
 
