From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 0/7] [ARM] s3c-fb: Various s3c-fb updates.
Date: Fri, 11 Sep 2009 20:04:45 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D57@bssrvexch01.BS.local>
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
this patch series adds some new features to the driver, as well as fixes to the existing register handling (patch 4/7).
It is rebased onto my previous patchset ([PATCH v2 0/3] v2: s3c-fb panning and vsync support).

The series contains:

[PATCH 1/7] [ARM] s3c-fb: Added colorkey support
[PATCH 2/7] [ARM] s3c-fb: Added window source selection.
[PATCH 3/7] [ARM] s3c-fb: Added support for alpha blending.
[PATCH 4/7] [ARM] s3c-fb: Corrected and added new VIDOSD register macros.
[PATCH 5/7] [ARM] s3c-fb: Added missing window enabled state updates.
[PATCH 6/7] [ARM] s3c-fb: Added debugfs interface.
[PATCH 7/7] [ARM] s3c-fb: Added color key blending.

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
