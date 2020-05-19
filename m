From: Sasha Levin <sashal@kernel.org>
Date: Tue, 19 May 2020 16:32:34 +0000
Subject: [RFC PATCH 4/4] gpu: dxgkrnl: create a MAINTAINERS entry
Message-Id: <20200519163234.226513-5-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexander.deucher@amd.com, chris@chris-wilson.co.uk, ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com, tvrtko.ursulin@intel.com
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, gregkh@linuxfoundation.org, haiyangz@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, spronovo@microsoft.com, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, kys@microsoft.com

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..dccdfadda5df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4997,6 +4997,13 @@ F:	Documentation/filesystems/dnotify.txt
 F:	fs/notify/dnotify/
 F:	include/linux/dnotify.h
 
+DirectX GPU DRIVER
+M:	Sasha Levin <sashal@kernel.org>
+M:	Iouri Tarassov <iourit@microsoft.com>
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+F:	drivers/gpu/dxgcore/
+
 DISK GEOMETRY AND PARTITION HANDLING
 M:	Andries Brouwer <aeb@cwi.nl>
 S:	Maintained
-- 
2.25.1
