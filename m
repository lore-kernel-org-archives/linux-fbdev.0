Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584074483A8;
	Thu,  6 Aug 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028714; cv=none; b=AmzBZwKFZ6Qm9CyepjoMi179RVEQAE63nfyzfzg02n282pzZb/eLve3peYSHvtLdRkL+wZXLqUPtKuJCfhRgncqzzocZ3F3eH2EWbkGa+7Y6RsFgh9UGuCh1EvYQMH9Gqp25j4RU9RbQHRz1GpSllENH0lNf0FN3WZkgIdUQFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028714; c=relaxed/simple;
	bh=orgLGllWh2lnoEBQ4JYQUYZM9EAqFWvuC1DruRncWG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omKDqZ+sihK2PuAYr17EcRqo8kzfpXVq6XYS6hdS9/aY0+A63Fw6O0GYyAiFyJiS1fYHxts/bOTZxYVKORr4BioZa38pe7jhpKnVtnuABVB3sdpHRDXGWauxaTuRl44TlLIs1PSdnJkhFjcLtwlSZUOdiW8sHC1ejejGKcGbxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8EpqDP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8EpqDP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA171F000E9;
	Thu,  6 Aug 2026 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786028712;
	bh=1Z3Rij5Y2TDRcGbge5gJ16K4Ai71Dj0D517MtFEVucY=;
	h=From:To:Cc:Subject:Date;
	b=F8EpqDP/NZMcNWBNq4noLlupXQnF+W/i3Gc+5RcOJhOkLaR+ektD3WjacvDW+2Nda
	 TTNZp1cEYJr1gE0/68MEOAtWOB4mTae23hMEfgIXo0M0k0IYflkdZuYkXYJgFB65PR
	 pymSWrdLXTlCFm5kWOplWPyfR+15bGbwjgxcRqfwaz4Q2Jj990zVIMYObN0TUyq1sv
	 lKzrOYXB67clExPvld6JCIFVdB8K7f7qjKjVpJ+Sk4DobMVPi4RKPAu59nO2fbx9wf
	 trjoX1siXf6FjQsMiul76Oe+pScxgBuk273t1ryYcOEl/cuBXeXLs7C/ZAxCOgAKlg
	 /W1kQASeNegGw==
From: Helge Deller <deller@kernel.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Cc: deller@gmx.de
Subject: [PATCH v2] sticon/parisc: Detect default STI graphics card for console output
Date: Thu,  6 Aug 2026 17:04:15 +0200
Message-ID: <20260806150414.7870-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

If a machine has multiple graphic cards, detect the graphic card which is used
to display firmware messages and use that one as the default graphic card for
sticon and fbcon.

On parisc machines the default graphic card used for BCH (boot console
handler, aka BIOS menu) is stored in the stable storage (equivalent to CMOS
storage on x86) or in the console path in page zero. Extract that path and
store it as default STI path for later comparism. Take care that the graphic
card can be a GSC or a PCI card which use different path strings.

Increase max string size for default_sti_path to 32 chars as the
print_pa_hwpath() function formats a hardware path using unbounded sprintf
calls for up to 6 bus converter components and 1 module component (e.g.,
255/255/...), which can produce a string up to 28 bytes long.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/sticore.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

v2: increase default_sti_path and take care of PCU cards as reported by
    the Sashiko AI bot review.

diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index 0d37e4b10447..1d4477f20450 100644
--- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -325,7 +325,7 @@ static void sti_rom_copy(unsigned long base, unsigned long count, void *dest)
 
 
 
-static char default_sti_path[21] __read_mostly;
+static char default_sti_path[32] __read_mostly;
 
 #ifndef MODULE
 static int __init sti_setup(char *str)
@@ -1148,6 +1148,26 @@ static void sti_init_roms(void)
 	pr_info("STI GSC/PCI core graphics driver "
 			STI_DRIVERVERSION "\n");
 
+	/*
+	 * Find default console by hardware path which is either stored in
+	 * console entry in stable storage or alternatively from console path
+	 * in PAGE0 used by BCH and PDC.
+	 */
+	if (!default_sti_path[0]) {
+		struct pdc_module_path conspath;
+		struct device *dev = NULL;
+
+		if (pdc_stable_read(0x60, &conspath, sizeof(conspath)) == PDC_OK)
+			dev = hwpath_to_device(&conspath.path);
+		if (!dev)
+			dev = hwpath_to_device(&PAGE0->mem_cons.dp.path);
+		if (dev && dev_is_pci(dev))
+			print_pci_hwpath(to_pci_dev(dev), default_sti_path);
+		else if (dev && !dev_is_pci(dev))
+			print_pa_hwpath(to_parisc_device(dev), default_sti_path);
+		pr_debug("default graphic card: %s\n", default_sti_path);
+	}
+
 	/* Register drivers for native & PCI cards */
 	register_parisc_driver(&pa_sti_driver);
 	WARN_ON(pci_register_driver(&pci_sti_driver));
-- 
2.54.0

