From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH v2 0/3] v2: s3c-fb panning and vsync support
Date: Thu, 03 Sep 2009 14:44:38 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0770658048@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Pawel Osciak <p.osciak@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "adaplas@gmail.com" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hello,

this is the second version of my previous patchset, corrected after your feedback (thank you).

[v2]:

In the panning patch:
* panning is done per-byte (the unit used in VIDW_BUF_START) and has been tested for different
bpps, including bpp < 8

* introduced the PRTCON register, which basically disables in-hardware updates from
shadow registers for VIDW_BUF_START/END (and a couple of others):
- shadow registers are updated on vsync (in hw)
- the update will not occur if PRTCON protection is enabled
This way we are safe when updating them at any time, even though they are separate.

In VSYNC patch:
* removed open() and release() functions as suggested (they were to disable interrupts at
release(), but this is already being taken care of in the isr)


The series contains:

[PATCH v2 1/3] [ARM] s3c-fb: Corrected defines for framesel1 register.
[PATCH v2 2/3] [ARM] s3c-fb: Added support for panning the display in both directions.
[PATCH v2 3/3] [ARM] s3c-fb: Added wait for VSYNC support.


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
