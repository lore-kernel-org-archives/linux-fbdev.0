From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:48 +0000
Subject: [RFC 00/14] Kernel based bootsplash
Message-Id: <20171025124602.28292-1-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Dear fbdev and fbcon developers,

Could you please voice your opinion on the following patch series?


This series adds simple bootsplash functionality on top of fbcon.

A (simple!) kernel based bootsplash allows system integrators to show an
earlier and more reliable bootsplash, completely hiding the kernel's
text output and VT (the 'quiet' option still displays warnings and a
blinking cursor).

Over the years, there have been many issues with a splash in userspace,
and the easiest fix is to show the splash in the kernel - see the first
commit for details. This is a huge simplification for embedded systems
and desktops alike.


As it is now, the bootsplash is implemented as a modification of fbcon,
but since the userspace ABI is a platform device, it can be moved
elsewhere in the future without breaking userspace.


If you would like an example splash file to test the code with, or even
a tool to generate it, I'm happy to provide them.


Finally, I will re-send the patch with the TODOs removed as soon as the
file format is accepted.



Many thanks to Takashi Iwai and Oliver Neukum for their continuous
feedback on the code during development of this series.

Max Staudt


