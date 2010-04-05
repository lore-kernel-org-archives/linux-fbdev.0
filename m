From: "Ambrose, Martin" <martin@ti.com>
Date: Mon, 05 Apr 2010 21:52:31 +0000
Subject: [PATCH v3 0/1] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <A24693684029E5489D1D202277BE89445316FACB@dlee02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Changes from v2 patch set:
        . Fixed register clear sequence in isr to avoid spurious interrupt.
        . Removed unused wait queue variable in wait_for_vsync().
        . Moved initialization of vsync_wait prior to register_framebuffer.
