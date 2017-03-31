From: Prasant Jalan <prasant.jalan@gmail.com>
Date: Fri, 31 Mar 2017 19:22:01 +0000
Subject: [PATCH 1/2] staging: sm750fb: fixing function return with lock held
Message-Id: <1490987402-9301-1-git-send-email-prasant.jalan@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: sudip.mukherjee@codethink.co.uk, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Prasant Jalan <prasant.jalan@gmail.com>

lynxfb_suspend() & lynxfb_resume() return on errors while holding
console_lock.

Adding 'goto' such that proper cleanups can be done before returning
from function and therefore console_lock can be released before
returning.

Signed-off-by: Prasant Jalan <prasant.jalan@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c618c56..445c68d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -419,7 +419,7 @@ static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"error:%d occurred in pci_save_state\n", ret);
-			return ret;
+			goto lynxfb_suspend_err;
 		}
 
 		ret = pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
@@ -427,11 +427,13 @@ static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
 			dev_err(&pdev->dev,
 				"error:%d occurred in pci_set_power_state\n",
 				ret);
-			return ret;
+			goto lynxfb_suspend_err;
 		}
 	}
 
 	pdev->dev.power.power_state = mesg;
+
+lynxfb_suspend_err:
 	console_unlock();
 	return ret;
 }
@@ -456,7 +458,7 @@ static int lynxfb_resume(struct pci_dev *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"error:%d occurred in pci_set_power_state\n", ret);
-		return ret;
+		goto lynxfb_resume_err;
 	}
 
 	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
@@ -466,7 +468,7 @@ static int lynxfb_resume(struct pci_dev *pdev)
 			dev_err(&pdev->dev,
 				"error:%d occurred in pci_enable_device\n",
 				ret);
-			return ret;
+			goto lynxfb_resume_err;
 		}
 		pci_set_master(pdev);
 	}
@@ -498,6 +500,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 	}
 
 	pdev->dev.power.power_state.event = PM_EVENT_RESUME;
+
+lynxfb_resume_err:
 	console_unlock();
 	return ret;
 }
-- 
2.7.4

