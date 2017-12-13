From: Max Staudt <mstaudt@suse.de>
Date: Wed, 13 Dec 2017 19:47:42 +0000
Subject: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <20171213194755.3409-1-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, mstaudt@suse.de, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

Dear fbdev and fbcon developers,

Thank you very much for your input for the first patch series.

I've included your feedback into this second roll, and kindly ask for
your opinion on the new patch series.


Changes from v1 to v2:

 + Added a user space tool to create splash theme files
 + Bumped the file format version:
    - Larger structs for easy future expansion
    - 2-byte corner offset
    - Offset either from corner or from center
    - Fixed padding before header->frame_ms
 + Moved bootsplash_file.h to uapi/linux
 + Merged several patches
 + Theme files are now loaded via request_firmware()
 + sysfs hook to allow loading of theme files via request_firmware()
 + Dropped the .enable cmdline option and the default file name.
   The splash will be shown as soon as a file is specified.
 + Dropped custom workqueue in favor of the kernel queue
   and cancel_delayed_work_sync()
 + Marked loaded data as const, and load/enable it atomically
 + Reduced global state by moving data into other structures
 + EXPORT_SYMBOL_GPL for fbcon_set_dummyops()
 + Atomic and barrier for splash enabled state instead of spinlock
 + Reduced warnings to infos
 + Rate limited printk
 + Changed the multi-line comment layout to kernel style
 + Simplified the file headers
 + reST-ed the documentation



Max





