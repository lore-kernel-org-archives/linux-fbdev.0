From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 16 May 2016 22:59:54 +0000
Subject: [PATCH 0/2] DEC frame buffer modular driver cleanups
Message-Id: <alpine.LFD.2.20.1605162316060.19898@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

 This is a pair of small cleanups for `__init' annotation issues in PMAG-B 
and PMAGB-B frame buffer drivers discovered in a modular build, which is a 
seldom used, but supported configuration.

 Please apply; I think these are obvious enough to be fast-tracked to 4.7 
right away.

  Maciej
