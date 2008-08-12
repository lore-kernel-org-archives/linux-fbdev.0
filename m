From: <JosephChan@via.com.tw>
Subject: [PATCH 1/13 v3] viafb: fix for the description
	of the VX800 2D acceleration issue in viafb.txt.
Date: Tue, 12 Aug 2008 08:53:47 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F4A00@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1578662951=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSi94-00052c-FC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 17:53:54 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSi93-0002hy-8s
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 17:53:54 -0700
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, geert@linux-m68k.org

This is a multi-part message in MIME format.

--===============1578662951==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8FC15.E1AAED9A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8FC15.E1AAED9A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Correct the description of VX800 2D acceleration, the driver diables the =
acceleration
function by defualt if you use VX800 chip.
Correct via_fb_ to viafb_ and remove the Kconfig part in viafb.txt.

viafb.modes: supported mode table
viafb.txt: documentation of viafb driver

Signed-off-by: Joseph Chan <josephchan@via.com.tw>

diff -Nurp a/Documentation/fb/viafb.modes b/Documentation/fb/viafb.modes
--- a/Documentation/fb/viafb.modes      1970-01-01 08:00:00.000000000 =
+0800
+++ b/Documentation/fb/viafb.modes      2008-07-22 02:07:29.000000000 =
+0800
@@ -0,0 +1,870 @@
+#
+#
+#   These data are based on the CRTC parameters in
+#
+#       VIA Integration Graphics Chip
+#       (C) 2004 VIA Technologies Inc.
+#
+
+#
+#   640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      640     480
+#   Scan Frequency      31.469 kHz  59.94 Hz
+#   Sync Width      3.813 us    0.064 ms
+#               12 chars    2 lines
+#   Front Porch     0.636 us    0.318  ms
+#               2 chars     10 lines
+#   Back Porch      1.907 us    1.048  ms
+#               6 chars     33 lines
+#   Active Time     25.422 us   15.253 ms
+#               80 chars    480 lines
+#   Blank Time      6.356 us    1.430 ms
+#               20 chars    45 lines
+#   Polarity        negative    negative
+#
+
+mode "640x480-60"
+# D: 25.175 MHz, H: 31.469 kHz, V: 59.94 Hz
+    geometry 640 480 640 480 32
+    timings 39722 48 16 33 10 96 2 endmode mode "480x640-60"
+# D: 24.823 MHz, H: 39.780 kHz, V: 60.00 Hz
+    geometry 480 640 480 640 32 timings 39722 72 24 19 1 48 3 endmode
+#
+#   640x480, 75 Hz, Non-Interlaced (31.50 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      640     480
+#   Scan Frequency      37.500 kHz  75.00 Hz
+#   Sync Width      2.032 us    0.080 ms
+#               8 chars     3 lines
+#   Front Porch     0.508 us    0.027 ms
+#               2 chars     1 lines
+#   Back Porch      3.810 us    0.427 ms
+#               15 chars    16 lines
+#   Active Time     20.317 us   12.800 ms
+#               80 chars    480 lines
+#   Blank Time      6.349 us    0.533 ms
+#               25 chars    20 lines
+#   Polarity        negative    negative
+#
+    mode "640x480-75"
+# D: 31.50 MHz, H: 37.500 kHz, V: 75.00 Hz
+    geometry 640 480 640 480 32 timings 31747 120 16 16 1 64 3 endmode
+#
+#   640x480, 85 Hz, Non-Interlaced (36.000 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      640     480
+#   Scan Frequency  43.269 kHz  85.00 Hz
+#   Sync Width      1.556 us    0.069 ms
+#               7 chars     3 lines
+#   Front Porch     1.556 us    0.023 ms
+#               7 chars     1 lines
+#   Back Porch      2.222 us    0.578 ms
+#               10 chars    25 lines
+#   Active Time     17.778 us   11.093 ms
+#               80 chars    480 lines
+#   Blank Time      5.333 us    0.670 ms
+#               24 chars    29 lines
+#   Polarity        negative    negative
+#
+    mode "640x480-85"
+# D: 36.000 MHz, H: 43.269 kHz, V: 85.00 Hz
+    geometry 640 480 640 480 32 timings 27777 80 56 25 1 56 3 endmode
+#
+#   640x480, 100 Hz, Non-Interlaced (43.163 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      640     480
+#   Scan Frequency      50.900 kHz  100.00 Hz
+#   Sync Width      1.483 us    0.058 ms
+#               8 chars     3 lines
+#   Front Porch     0.927 us    0.019 ms
+#               5 chars     1 lines
+#   Back Porch      2.409 us    0.475 ms
+#               13 chars    25 lines
+#   Active Time     14.827 us   9.430 ms
+#               80 chars    480 lines
+#   Blank Time      4.819 us    0.570 ms
+#               26 chars    29 lines
+#   Polarity        positive    positive
+#
+    mode "640x480-100"
+# D: 43.163 MHz, H: 50.900 kHz, V: 100.00 Hz
+    geometry 640 480 640 480 32 timings 23168 104 40 25 1 64 3 endmode
+#
+#   640x480, 120 Hz, Non-Interlaced (52.406 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      640     480
+#   Scan Frequency      61.800 kHz  120.00 Hz
+#   Sync Width      1.221 us    0.048 ms
+#               8 chars         3 lines
+#   Front Porch     0.763 us    0.016 ms
+#               5 chars     1 lines
+#   Back Porch      1.984 us    0.496 ms
+#               13 chars    31 lines
+#   Active Time     12.212 us   7.767 ms
+#               80 chars    480 lines
+#   Blank Time      3.969 us    0.566 ms
+#               26 chars    35 lines
+#   Polarity        positive    positive
+#
+    mode "640x480-120"
+# D: 52.406 MHz, H: 61.800 kHz, V: 120.00 Hz
+    geometry 640 480 640 480 32 timings 19081 104 40 31 1 64 3 endmode
+#
+#   720x480, 60 Hz, Non-Interlaced (26.880 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      720     480
+#   Scan Frequency      30.000 kHz  60.241 Hz
+#   Sync Width      2.679 us    0.099 ms
+#               9 chars     3 lines
+#   Front Porch     0.595 us    0.033 ms
+#               2 chars     1 lines
+#   Back Porch      3.274 us    0.462 ms
+#               11 chars    14 lines
+#   Active Time     26.786 us   16.000 ms
+#               90 chars    480 lines
+#   Blank Time      6.548 us    0.600 ms
+#               22 chars    18 lines
+#   Polarity        positive    positive
+#
+    mode "720x480-60"
+# D: 26.880 MHz, H: 30.000 kHz, V: 60.24 Hz
+    geometry 720 480 720 480 32 timings 37202 88 16 14 1 72 3 endmode
+#
+#   800x480, 60 Hz, Non-Interlaced (29.581 MHz dotclock)
+#
+#               Horizontal    Vertical
+#   Resolution      800         480
+#   Scan Frequency  29.892 kHz  60.00 Hz
+#   Sync Width      2.704 us    100.604 us
+#                   10 chars    3 lines
+#   Front Porch     0.541 us    33.535 us
+#                   2 chars     1 lines
+#   Back Porch      3.245 us    435.949 us
+#                   12 chars    13 lines
+#   Active Time     27.044 us   16.097 ms
+#                   100 chars   480 lines
+#   Blank Time      6.491 us    0.570 ms
+#                   24 chars    17 lines
+#   Polarity        positive    positive
+#
+    mode "800x480-60"
+# D: 29.500 MHz, H: 29.738 kHz, V: 60.00 Hz
+    geometry 800 480 800 480 32 timings 33805 96 24 10 3 72 7 endmode
+#
+#   720x576, 60 Hz, Non-Interlaced (32.668 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      720     576
+#   Scan Frequency      35.820 kHz  60.00 Hz
+#   Sync Width      2.204 us    0.083 ms
+#               9 chars     3 lines
+#   Front Porch     0.735 us    0.027 ms
+#               3 chars     1 lines
+#   Back Porch      2.939 us    0.459 ms
+#               12 chars    17 lines
+#   Active Time     22.040 us   16.080 ms
+#               90 chars    476 lines
+#   Blank Time      5.877 us    0.586 ms
+#               24 chars    21 lines
+#   Polarity        positive    positive
+#
+    mode "720x576-60"
+# D: 32.668 MHz, H: 35.820 kHz, V: 60.00 Hz
+    geometry 720 576 720 576 32 timings 30611 96 24 17 1 72 3 endmode
+#
+#   800x600, 60 Hz, Non-Interlaced (40.00 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      800     600
+#   Scan Frequency      37.879 kHz  60.32 Hz
+#   Sync Width      3.200 us    0.106 ms
+#               16 chars    4 lines
+#   Front Porch     1.000 us    0.026 ms
+#               5 chars     1 lines
+#   Back Porch      2.200 us    0.607 ms
+#               11 chars    23 lines
+#   Active Time     20.000 us   15.840 ms
+#               100 chars   600 lines
+#   Blank Time      6.400 us    0.739 ms
+#               32 chars    28 lines
+#   Polarity        positive    positive
+#
+    mode "800x600-60"
+# D: 40.00 MHz, H: 37.879 kHz, V: 60.32 Hz
+    geometry 800 600 800 600 32
+    timings 25000 88 40 23 1 128 4 hsync high vsync high endmode
+#
+#   800x600, 75 Hz, Non-Interlaced (49.50 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      800     600
+#   Scan Frequency      46.875 kHz  75.00 Hz
+#   Sync Width      1.616 us    0.064 ms
+#               10 chars    3 lines
+#   Front Porch     0.323 us    0.021 ms
+#               2 chars     1 lines
+#   Back Porch      3.232 us    0.448 ms
+#               20 chars    21 lines
+#   Active Time     16.162 us   12.800 ms
+#               100 chars   600 lines
+#   Blank Time      5.172 us    0.533 ms
+#               32 chars    25 lines
+#   Polarity        positive    positive
+#
+    mode "800x600-75"
+# D: 49.50 MHz, H: 46.875 kHz, V: 75.00 Hz
+    geometry 800 600 800 600 32
+    timings 20203 160 16 21 1 80 3 hsync high vsync high endmode
+#
+#   800x600, 85 Hz, Non-Interlaced (56.25 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      800     600
+#   Scan Frequency      53.674 kHz  85.061 Hz
+#   Sync Width      1.138 us    0.056 ms
+#               8 chars     3 lines
+#   Front Porch     0.569 us    0.019 ms
+#               4 chars     1 lines
+#   Back Porch      2.702 us    0.503 ms
+#               19 chars    27 lines
+#   Active Time     14.222 us   11.179 ms
+#               100 chars   600 lines
+#   Blank Time      4.409 us    0.578 ms
+#               31 chars    31 lines
+#   Polarity        positive    positive
+#
+    mode "800x600-85"
+# D: 56.25 MHz, H: 53.674 kHz, V: 85.061 Hz
+    geometry 800 600 800 600 32
+    timings 17777 152 32 27 1 64 3 hsync high vsync high endmode
+#
+#   800x600, 100 Hz, Non-Interlaced (67.50 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      800     600
+#   Scan Frequency      62.500 kHz  100.00 Hz
+#   Sync Width      0.948 us    0.064 ms
+#               8 chars     4 lines
+#   Front Porch     0.000 us    0.112 ms
+#               0 chars     7 lines
+#   Back Porch      3.200 us    0.224 ms
+#               27 chars    14 lines
+#   Active Time     11.852 us   9.600 ms
+#               100 chars   600 lines
+#   Blank Time      4.148 us    0.400 ms
+#               35 chars    25 lines
+#   Polarity        positive    positive
+#
+    mode "800x600-100"
+# D: 67.50 MHz, H: 62.500 kHz, V: 100.00 Hz
+    geometry 800 600 800 600 32
+    timings 14667 216 0 14 7 64 4 hsync high vsync high endmode
+#
+#   800x600, 120 Hz, Non-Interlaced (83.950 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      800     600
+#   Scan Frequency  77.160 kHz  120.00 Hz
+#   Sync Width      1.048 us    0.039 ms
+#               11 chars    3 lines
+#   Front Porch     0.667 us    0.013 ms
+#               7 chars     1 lines
+#   Back Porch      1.715 us    0.507 ms
+#               18 chars    39 lines
+#   Active Time     9.529 us    7.776 ms
+#               100 chars   600 lines
+#   Blank Time      3.431 us    0.557 ms
+#               36 chars    43 lines
+#   Polarity        positive    positive
+#
+    mode "800x600-120"
+# D: 83.950 MHz, H: 77.160 kHz, V: 120.00 Hz
+    geometry 800 600 800 600 32
+    timings 11912 144 56 39 1 88 3 hsync high vsync high endmode
+#
+#   848x480, 60 Hz, Non-Interlaced (31.490 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      848     480
+#   Scan Frequency  29.820 kHz  60.00 Hz
+#   Sync Width      2.795 us    0.099 ms
+#               11 chars    3 lines
+#   Front Porch     0.508 us    0.033 ms
+#               2 chars     1 lines
+#   Back Porch      3.303 us    0.429 ms
+#               13 chars    13 lines
+#   Active Time     26.929 us   16.097 ms
+#               106 chars   480 lines
+#   Blank Time      6.605 us    0.570 ms
+#               26 chars    17 lines
+#   Polarity        positive    positive
+#
+    mode "848x480-60"
+# D: 31.500 MHz, H: 29.830 kHz, V: 60.00 Hz
+    geometry 848 480 848 480 32
+    timings 31746 104 24 12 3 80 5 hsync high vsync high endmode
+#
+#   856x480, 60 Hz, Non-Interlaced (31.728 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      856     480
+#   Scan Frequency  29.820 kHz  60.00 Hz
+#   Sync Width      2.774 us    0.099 ms
+#               11 chars    3 lines
+#   Front Porch     0.504 us    0.033 ms
+#               2 chars     1 lines
+#   Back Porch      3.728 us    0.429 ms
+#               13 chars    13 lines
+#   Active Time     26.979 us   16.097 ms
+#               107 chars   480 lines
+#   Blank Time      6.556 us    0.570 ms
+#               26 chars    17 lines
+#   Polarity        positive    positive
+#
+    mode "856x480-60"
+# D: 31.728 MHz, H: 29.820 kHz, V: 60.00 Hz
+    geometry 856 480 856 480 32
+    timings 31518 104 16 13 1 88 3
+    hsync high vsync high endmode mode "960x600-60"
+# D: 45.250 MHz, H: 37.212 kHz, V: 60.00 Hz
+    geometry 960 600 960 600 32 timings 22099 128 32 15 3 96 6 endmode
+#
+#   1000x600, 60 Hz, Non-Interlaced (48.068 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1000     600
+#   Scan Frequency  37.320 kHz  60.00 Hz
+#   Sync Width      2.164 us    0.080 ms
+#               13 chars    3 lines
+#   Front Porch     0.832 us    0.027 ms
+#               5 chars     1 lines
+#   Back Porch      2.996 us    0.483 ms
+#               18 chars    18 lines
+#   Active Time     20.804 us   16.077 ms
+#               125 chars   600 lines
+#   Blank Time      5.991 us    0.589 ms
+#               36 chars    22 lines
+#   Polarity        negative    positive
+#
+    mode "1000x600-60"
+# D: 48.068 MHz, H: 37.320 kHz, V: 60.00 Hz
+    geometry 1000 600 1000 600 32
+    timings 20834 144 40 18 1 104 3 endmode mode "1024x576-60"
+# D: 46.996 MHz, H: 35.820 kHz, V: 60.00 Hz
+    geometry 1024 576 1024 576 32
+    timings 21278 144 40 17 1 104 3 endmode mode "1024x600-60"
+# D: 48.964 MHz, H: 37.320 kHz, V: 60.00 Hz
+    geometry 1024 600 1024 600 32
+    timings 20461 144 40 18 1 104 3 endmode mode "1088x612-60"
+# D: 52.952 MHz, H: 38.040 kHz, V: 60.00 Hz
+    geometry 1088 612 1088 612 32 timings 18877 152 48 16 3 104 5 =
endmode
+#
+#   1024x512, 60 Hz, Non-Interlaced (41.291 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1024    512
+#   Scan Frequency  31.860 kHz  60.00 Hz
+#   Sync Width      2.519 us    0.094 ms
+#               13 chars    3 lines
+#   Front Porch     0.775 us    0.031 ms
+#               4 chars     1 lines
+#   Back Porch      3.294 us    0.465 ms
+#               17 chars    15 lines
+#   Active Time     24.800 us   16.070 ms
+#               128 chars   512 lines
+#   Blank Time      6.587 us    0.596 ms
+#               34 chars    19 lines
+#   Polarity        positive    positive
+#
+    mode "1024x512-60"
+# D: 41.291 MHz, H: 31.860 kHz, V: 60.00 Hz
+    geometry 1024 512 1024 512 32
+    timings 24218 126 32 15 1 104 3 hsync high vsync high endmode
+#
+#   1024x600, 60 Hz, Non-Interlaced (48.875 MHz dotclock)
+#
+#                     Horizontal  Vertical
+#   Resolution          1024        768
+#   Scan Frequency      37.252 kHz  60.00 Hz
+#   Sync Width          2.128 us    80.532us
+#                       13 chars    3 lines
+#   Front Porch        0.818 us     26.844 us
+#                       5 chars     1 lines
+#   Back Porch          2.946 us    483.192 us
+#                       18 chars    18 lines
+#   Active Time         20.951 us   16.697 ms
+#                       128 chars   622 lines
+#   Blank Time          5.893 us    0.591 ms
+#                       36 chars    22 lines
+#   Polarity            negative    positive
+#
+#mode "1024x600-60"
+#     # D: 48.875 MHz, H: 37.252 kHz, V: 60.00 Hz
+#     geometry 1024 600 1024 600 32
+#    timings 20460  144 40 18 1 104  3
+# endmode
+#
+#   1024x768, 60 Hz, Non-Interlaced (65.00 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1024        768
+#   Scan Frequency      48.363 kHz  60.00 Hz
+#   Sync Width      2.092 us    0.124 ms
+#               17 chars    6 lines
+#   Front Porch     0.369 us    0.062 ms
+#               3 chars     3 lines
+#   Back Porch      2.462 us    0.601 ms
+#               20 chars    29 lines
+#   Active Time     15.754 us   15.880 ms
+#               128 chars   768 lines
+#   Blank Time      4.923 us    0.786 ms
+#               40 chars    38 lines
+#   Polarity        negative    negative
+#
+    mode "1024x768-60"
+# D: 65.00 MHz, H: 48.363 kHz, V: 60.00 Hz
+    geometry 1024 768 1024 768 32 timings 15385 160 24 29 3 136 6 =
endmode
+#
+#   1024x768, 75 Hz, Non-Interlaced (78.75 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1024        768
+#   Scan Frequency      60.023 kHz  75.03 Hz
+#   Sync Width      1.219 us    0.050 ms
+#               12 chars    3 lines
+#   Front Porch     0.203 us    0.017 ms
+#               2 chars     1 lines
+#   Back Porch      2.235 us    0.466 ms
+#               22 chars    28 lines
+#   Active Time     13.003 us   12.795 ms
+#               128 chars   768 lines
+#   Blank Time      3.657 us    0.533 ms
+#               36 chars    32 lines
+#   Polarity        positive    positive
+#
+    mode "1024x768-75"
+# D: 78.75 MHz, H: 60.023 kHz, V: 75.03 Hz
+    geometry 1024 768 1024 768 32
+    timings 12699 176 16 28 1 96 3 hsync high vsync high endmode
+#
+#   1024x768, 85 Hz, Non-Interlaced (94.50 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1024        768
+#   Scan Frequency  68.677 kHz  85.00 Hz
+#   Sync Width      1.016 us    0.044 ms
+#               12 chars    3 lines
+#   Front Porch     0.508 us    0.015 ms
+#               6 chars     1 lines
+#   Back Porch      2.201 us    0.524 ms
+#               26 chars    36 lines
+#   Active Time     10.836 us   11.183 ms
+#               128 chars   768 lines
+#   Blank Time      3.725 us    0.582 ms
+#               44 chars    40 lines
+#   Polarity        positive    positive
+#
+    mode "1024x768-85"
+# D: 94.50 MHz, H: 68.677 kHz, V: 85.00 Hz
+    geometry 1024 768 1024 768 32
+    timings 10582 208 48 36 1 96 3 hsync high vsync high endmode
+#
+#   1024x768, 100 Hz, Non-Interlaced (110.0 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1024        768
+#   Scan Frequency      79.023 kHz  99.78 Hz
+#   Sync Width      0.800 us    0.101 ms
+#               11 chars    8 lines
+#   Front Porch     0.000 us    0.000 ms
+#               0 chars     0 lines
+#   Back Porch      2.545 us    0.202 ms
+#               35 chars    16 lines
+#   Active Time     9.309 us    9.719 ms
+#               128 chars   768 lines
+#   Blank Time      3.345 us    0.304 ms
+#               46 chars    24 lines
+#   Polarity        negative    negative
+#
+    mode "1024x768-100"
+# D: 113.3 MHz, H: 79.023 kHz, V: 99.78 Hz
+    geometry 1024 768 1024 768 32
+    timings 8825 280 0 16 0 88 8 endmode mode "1152x720-60"
+# D: 66.750 MHz, H: 44.859 kHz, V: 60.00 Hz
+    geometry 1152 720 1152 720 32 timings 14981 168 56 19 3 112 6 =
endmode
+#
+#   1152x864, 75 Hz, Non-Interlaced (110.0 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1152        864
+#   Scan Frequency      75.137 kHz  74.99 Hz
+#   Sync Width      1.309 us    0.106 ms
+#               18 chars    8 lines
+#   Front Porch     0.245 us    0.599 ms
+#               3 chars     45 lines
+#   Back Porch      1.282 us    1.132 ms
+#               18 chars    85 lines
+#   Active Time     10.473 us   11.499 ms
+#               144 chars   864 lines
+#   Blank Time      2.836 us    1.837 ms
+#               39 chars    138 lines
+#   Polarity        positive    positive
+#
+    mode "1152x864-75"
+# D: 110.0 MHz, H: 75.137 kHz, V: 74.99 Hz
+    geometry 1152 864 1152 864 32
+    timings 9259 144 24 85 45 144 8
+    hsync high vsync high endmode mode "1200x720-60"
+# D: 70.184 MHz, H: 44.760 kHz, V: 60.00 Hz
+    geometry 1200 720 1200 720 32
+    timings 14253 184 28 22 1 128 3 endmode mode "1280x600-60"
+# D: 61.503 MHz, H: 37.320 kHz, V: 60.00 Hz
+    geometry 1280 600 1280 600 32
+    timings 16260 184 28 18 1 128 3 endmode mode "1280x720-50"
+# D: 60.466 MHz, H: 37.050 kHz, V: 50.00 Hz
+    geometry 1280 720 1280 720 32
+    timings 16538 176 48 17 1 128 3 endmode mode "1280x768-50"
+# D: 65.178 MHz, H: 39.550 kHz, V: 50.00 Hz
+    geometry 1280 768 1280 768 32 timings 15342 184 28 19 1 128 3 =
endmode
+#
+#   1280x768, 60 Hz, Non-Interlaced (80.136 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280    768
+#   Scan Frequency  47.700 kHz  60.00 Hz
+#   Sync Width      1.697 us    0.063 ms
+#               17 chars    3 lines
+#   Front Porch     0.799 us    0.021 ms
+#               8 chars     1 lines
+#   Back Porch      2.496 us    0.483 ms
+#               25 chars    23 lines
+#   Active Time     15.973 us   16.101 ms
+#               160 chars   768 lines
+#   Blank Time      4.992 us    0.566 ms
+#               50 chars    27 lines
+#   Polarity        positive    positive
+#
+    mode "1280x768-60"
+# D: 80.13 MHz, H: 47.700 kHz, V: 60.00 Hz
+    geometry 1280 768 1280 768 32
+    timings 12480 200 48 23 1 126 3 hsync high vsync high endmode
+#
+#   1280x800, 60 Hz, Non-Interlaced (83.375 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280    800
+#   Scan Frequency  49.628 kHz  60.00 Hz
+#   Sync Width      1.631 us    60.450 us
+#                   17 chars    3 lines
+#   Front Porch     0.768 us    20.15 us
+#                   8 chars     1 lines
+#   Back Porch      2.399 us    0.483 ms
+#                   25 chars    24 lines
+#   Active Time     15.352 us   16.120 ms
+#                   160 chars   800 lines
+#   Blank Time      4.798 us    0.564 ms
+#                   50 chars    28 lines
+#   Polarity        negtive    positive
+#
+    mode "1280x800-60"
+# D: 83.500 MHz, H: 49.702 kHz, V: 60.00 Hz
+    geometry 1280 800 1280 800 32 timings 11994 200 72 22 3 128 6 =
endmode
+#
+#   1280x960, 60 Hz, Non-Interlaced (108.00 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280    960
+#   Scan Frequency  60.000 kHz  60.00 Hz
+#   Sync Width      1.037 us    0.050 ms
+#               14 chars    3 lines
+#   Front Porch     0.889 us    0.017 ms
+#               12 chars    1 lines
+#   Back Porch      2.889 us    0.600 ms
+#               39 chars    36 lines
+#   Active Time     11.852 us   16.000 ms
+#               160 chars   960 lines
+#   Blank Time      4.815 us    0.667 ms
+#               65 chars    40 lines
+#   Polarity        positive    positive
+#
+    mode "1280x960-60"
+# D: 108.00 MHz, H: 60.000 kHz, V: 60.00 Hz
+    geometry 1280 960 1280 960 32
+    timings 9259 312 96 36 1 112 3 hsync high vsync high endmode
+#
+#   1280x1024, 60 Hz, Non-Interlaced (108.00 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280        1024
+#   Scan Frequency      63.981 kHz  60.02 Hz
+#   Sync Width      1.037 us    0.047 ms
+#               14 chars    3 lines
+#   Front Porch     0.444 us    0.015 ms
+#               6 chars     1 lines
+#   Back Porch      2.297 us    0.594 ms
+#               31 chars    38 lines
+#   Active Time     11.852 us   16.005 ms
+#               160 chars   1024 lines
+#   Blank Time      3.778 us    0.656 ms
+#               51 chars    42 lines
+#   Polarity        positive    positive
+#
+    mode "1280x1024-60"
+# D: 108.00 MHz, H: 63.981 kHz, V: 60.02 Hz
+    geometry 1280 1024 1280 1024 32
+    timings 9260 248 48 38 1 112 3 hsync high vsync high endmode
+#
+#   1280x1024, 75 Hz, Non-Interlaced (135.00 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280        1024
+#   Scan Frequency      79.976 kHz  75.02 Hz
+#   Sync Width      1.067 us    0.038 ms
+#               18 chars    3 lines
+#   Front Porch     0.119 us    0.012 ms
+#               2 chars     1 lines
+#   Back Porch      1.837 us    0.475 ms
+#               31 chars    38 lines
+#   Active Time     9.481 us    12.804 ms
+#               160 chars   1024 lines
+#   Blank Time      3.022 us    0.525 ms
+#               51 chars    42 lines
+#   Polarity        positive    positive
+#
+    mode "1280x1024-75"
+# D: 135.00 MHz, H: 79.976 kHz, V: 75.02 Hz
+    geometry 1280 1024 1280 1024 32
+    timings 7408 248 16 38 1 144 3 hsync high vsync high endmode
+#
+#   1280x1024, 85 Hz, Non-Interlaced (157.50 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280        1024
+#   Scan Frequency  91.146 kHz  85.02 Hz
+#   Sync Width      1.016 us    0.033 ms
+#               20 chars    3 lines
+#   Front Porch     0.406 us    0.011 ms
+#               8 chars     1 lines
+#   Back Porch      1.422 us    0.483 ms
+#               28 chars    44 lines
+#   Active Time     8.127 us    11.235 ms
+#               160 chars   1024 lines
+#   Blank Time      2.844 us    0.527 ms
+#               56 chars    48 lines
+#   Polarity        positive    positive
+#
+    mode "1280x1024-85"
+# D: 157.50 MHz, H: 91.146 kHz, V: 85.02 Hz
+    geometry 1280 1024 1280 1024 32
+    timings 6349 224 64 44 1 160 3
+    hsync high vsync high endmode mode "1440x900-60"
+# D: 106.500 MHz, H: 55.935 kHz, V: 60.00 Hz
+    geometry 1440 900 1440 900 32
+    timings 9390 232 80 25 3 152 6
+    hsync high vsync high endmode mode "1440x900-75"
+# D: 136.750 MHz, H: 70.635 kHz, V: 75.00 Hz
+    geometry 1440 900 1440 900 32
+    timings 7315 248 96 33 3 152 6 hsync high vsync high endmode
+#
+#   1440x1050, 60 Hz, Non-Interlaced (125.10 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1440        1050
+#   Scan Frequency      65.220 kHz  60.00 Hz
+#   Sync Width      1.204 us    0.046 ms
+#               19 chars    3 lines
+#   Front Porch     0.760 us    0.015 ms
+#               12 chars    1 lines
+#   Back Porch      1.964 us    0.495 ms
+#               31 chars    33 lines
+#   Active Time     11.405 us   16.099 ms
+#               180 chars   1050 lines
+#   Blank Time      3.928 us    0.567 ms
+#               62 chars    37 lines
+#   Polarity        positive    positive
+#
+    mode "1440x1050-60"
+# D: 125.10 MHz, H: 65.220 kHz, V: 60.00 Hz
+    geometry 1440 1050 1440 1050 32
+    timings 7993 248 96 33 1 152 3
+    hsync high vsync high endmode mode "1600x900-60"
+# D: 118.250 MHz, H: 55.990 kHz, V: 60.00 Hz
+    geometry 1600 900 1600 900 32
+    timings 8415 256 88 26 3 168 5 endmode mode "1600x1024-60"
+# D: 136.358 MHz, H: 63.600 kHz, V: 60.00 Hz
+    geometry 1600 1024 1600 1024 32 timings 7315 272 104 32 1 168 3 =
endmode
+#
+#   1600x1200, 60 Hz, Non-Interlaced (156.00 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1600        1200
+#   Scan Frequency      76.200 kHz  60.00 Hz
+#   Sync Width      1.026 us    0.105 ms
+#               20 chars    8 lines
+#   Front Porch     0.205 us    0.131 ms
+#               4 chars     10 lines
+#   Back Porch      1.636 us    0.682 ms
+#               32 chars    52 lines
+#   Active Time     10.256 us   15.748 ms
+#               200 chars   1200 lines
+#   Blank Time      2.872 us    0.866 ms
+#               56 chars    66 lines
+#   Polarity        negative    negative
+#
+    mode "1600x1200-60"
+# D: 156.00 MHz, H: 76.200 kHz, V: 60.00 Hz
+    geometry 1600 1200 1600 1200 32 timings 6172 256 32 52 10 160 8 =
endmode
+#
+#   1600x1200, 75 Hz, Non-Interlaced (202.50 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1600        1200
+#   Scan Frequency  93.750 kHz  75.00 Hz
+#   Sync Width      0.948 us    0.032 ms
+#               24 chars    3 lines
+#   Front Porch     0.316 us    0.011 ms
+#               8 chars     1 lines
+#   Back Porch      1.501 us    0.491 ms
+#               38 chars    46 lines
+#   Active Time     7.901 us    12.800 ms
+#               200 chars   1200 lines
+#   Blank Time      2.765 us    0.533 ms
+#               70 chars    50 lines
+#   Polarity    positive    positive
+#
+    mode "1600x1200-75"
+# D: 202.50 MHz, H: 93.750 kHz, V: 75.00 Hz
+    geometry 1600 1200 1600 1200 32
+    timings 4938 304 64 46 1 192 3
+    hsync high vsync high endmode mode "1680x1050-60"
+# D: 146.250 MHz, H: 65.290 kHz, V: 59.954 Hz
+    geometry 1680 1050 1680 1050 32
+    timings 6814 280 104 30 3 176 6
+    hsync high vsync high endmode mode "1680x1050-75"
+# D: 187.000 MHz, H: 82.306 kHz, V: 74.892 Hz
+    geometry 1680 1050 1680 1050 32
+    timings 5348 296 120 40 3 176 6
+    hsync high vsync high endmode mode "1792x1344-60"
+# D: 202.975 MHz, H: 83.460 kHz, V: 60.00 Hz
+    geometry 1792 1344 1792 1344 32
+    timings 4902 320 128 43 1 192 3
+    hsync high vsync high endmode mode "1856x1392-60"
+# D: 218.571 MHz, H: 86.460 kHz, V: 60.00 Hz
+    geometry 1856 1392 1856 1392 32
+    timings 4577 336 136 45 1 200 3
+    hsync high vsync high endmode mode "1920x1200-60"
+# D: 193.250 MHz, H: 74.556 kHz, V: 60.00 Hz
+    geometry 1920 1200 1920 1200 32
+    timings 5173 336 136 36 3 200 6
+    hsync high vsync high endmode mode "1920x1440-60"
+# D: 234.000 MHz, H:90.000 kHz, V: 60.00 Hz
+    geometry 1920 1440 1920 1440 32
+    timings 4274 344 128 56 1 208 3
+    hsync high vsync high endmode mode "1920x1440-75"
+# D: 297.000 MHz, H:112.500 kHz, V: 75.00 Hz
+    geometry 1920 1440 1920 1440 32
+    timings 3367 352 144 56 1 224 3
+    hsync high vsync high endmode mode "2048x1536-60"
+# D: 267.250 MHz, H: 95.446 kHz, V: 60.00 Hz
+    geometry 2048 1536 2048 1536 32
+    timings 3742 376 152 49 3 224 4 hsync high vsync high endmode
+#
+#   1280x720, 60 Hz, Non-Interlaced (74.481 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1280        720
+#   Scan Frequency      44.760 kHz  60.00 Hz
+#   Sync Width      1.826 us    67.024 ms
+#               17 chars    3 lines
+#   Front Porch     0.752 us    22.341 ms
+#               7 chars     1 lines
+#   Back Porch      2.578 us    491.510 ms
+#               24 chars    22 lines
+#   Active Time     17.186 us   16.086 ms
+#               160 chars   720 lines
+#   Blank Time      5.156 us    0.581 ms
+#               48 chars    26 lines
+#   Polarity        negative    negative
+#
+    mode "1280x720-60"
+# D: 74.481 MHz, H: 44.760 kHz, V: 60.00 Hz
+    geometry 1280 720 1280 720 32 timings 13426 192 64 22 1 136 3 =
endmode
+#
+#   1920x1080, 60 Hz, Non-Interlaced (172.798 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1920        1080
+#   Scan Frequency      67.080 kHz  60.00 Hz
+#   Sync Width      1.204 us    44.723 ms
+#               26 chars    3 lines
+#   Front Porch     0.694 us    14.908 ms
+#               15 chars     1 lines
+#   Back Porch      1.898 us    506.857 ms
+#               41 chars    34 lines
+#   Active Time     11.111 us   16.100 ms
+#               240 chars   1080 lines
+#   Blank Time      3.796 us    0.566 ms
+#               82 chars    38 lines
+#   Polarity        negative    negative
+#
+    mode "1920x1080-60"
+# D: 74.481 MHz, H: 67.080 kHz, V: 60.00 Hz
+    geometry 1920 1080 1920 1080 32 timings 5787 328 120 34 1 208 3 =
endmode
+#
+#   1400x1050, 60 Hz, Non-Interlaced (122.61 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1400        1050
+#   Scan Frequency      65.218 kHz  59.99 Hz
+#   Sync Width      1.037 us    0.047 ms
+#               19 chars    3 lines
+#   Front Porch     0.444 us    0.015 ms
+#               11 chars     1 lines
+#   Back Porch      1.185 us    0.188 ms
+#               30 chars    33 lines
+#   Active Time     12.963 us   16.411 ms
+#               175 chars   1050 lines
+#   Blank Time      2.667 us    0.250 ms
+#               60 chars    37 lines
+#   Polarity        negative    positive
+#
+    mode "1400x1050-60"
+# D: 122.750 MHz, H: 65.317 kHz, V: 59.99 Hz
+    geometry 1400 1050 1408 1050 32
+    timings 8214 232 88 32 3 144 4 endmode mode "1400x1050-75"
+# D: 156.000 MHz, H: 82.278 kHz, V: 74.867 Hz
+    geometry 1400 1050 1408 1050 32 timings 6410 248 104 42 3 144 4 =
endmode
+#
+#   1366x768, 60 Hz, Non-Interlaced (85.86 MHz dotclock)
+#
+#               Horizontal  Vertical
+#   Resolution      1366        768
+#   Scan Frequency      47.700 kHz  60.00 Hz
+#   Sync Width      1.677 us    0.063 ms
+#               18 chars    3 lines
+#   Front Porch     0.839 us    0.021 ms
+#               9 chars     1 lines
+#   Back Porch      2.516 us    0.482 ms
+#               27 chars    23 lines
+#   Active Time     15.933 us   16.101 ms
+#               171 chars   768 lines
+#   Blank Time      5.031 us    0.566 ms
+#               54 chars    27 lines
+#   Polarity        negative    positive
+#
+    mode "1360x768-60"
+# D: 84.750 MHz, H: 47.720 kHz, V: 60.00 Hz
+    geometry 1360 768 1360 768 32
+    timings 11799 208 72 22 3 136 5 endmode mode "1366x768-60"
+# D: 85.86 MHz, H: 47.700 kHz, V: 60.00 Hz
+    geometry 1366 768 1366 768 32
+    timings 11647 216 72 23 1 144 3 endmode mode "1366x768-50"
+# D: 69,924 MHz, H: 39.550 kHz, V: 50.00 Hz
+    geometry 1366 768 1366 768 32 timings 14301 200 56 19 1 144 3 =
endmode
diff -Nurp a/Documentation/fb/viafb.txt b/Documentation/fb/viafb.txt
--- a/Documentation/fb/viafb.txt        1970-01-01 08:00:00.000000000 =
+0800
+++ b/Documentation/fb/viafb.txt        2008-08-11 04:01:43.000000000 =
+0800
@@ -0,0 +1,214 @@
+
+        VIA Integration Graphic Chip Console Framebuffer Driver
+
+[Platform]
+-----------------------
+    The console framebuffer driver is for graphics chips of
+    VIA UniChrome Family(CLE266, PM800 / CN400 / CN300,
+                        P4M800CE / P4M800Pro / CN700 / VN800,
+                        CX700 / VX700, K8M890, P4M890,
+                        CN896 / P4M900, VX800)
+
+[Driver features]
+------------------------
+    Device: CRT, LCD, DVI
+
+    Support viafb_mode:
+        CRT: =20
+            640x480(60, 75, 85, 100, 120 Hz), 720x480(60 Hz),
+            720x576(60 Hz), 800x600(60, 75, 85, 100, 120 Hz),
+            848x480(60 Hz), 856x480(60 Hz), 1024x512(60 Hz),
+            1024x768(60, 75, 85, 100 Hz), 1152x864(75 Hz),
+            1280x768(60 Hz), 1280x960(60 Hz), 1280x1024(60, 75, 85 Hz),
+            1440x1050(60 Hz), 1600x1200(60, 75 Hz), 1280x720(60 Hz),
+            1920x1080(60 Hz), 1400x1050(60 Hz), 800x480(60 Hz)
+
+    color depth: 8 bpp, 16 bpp, 32 bpp supports.
+
+    Support 2D hardware accelerator.
+
+[Using the viafb module]
+-- -- --------------------
+    Start viafb with default settings:
+        #modprobe viafb
+
+    Start viafb with with user options:
+        #modprobe viafb viafb_mode=3D800x600 viafb_bpp=3D16 =
viafb_refresh=3D60
+                  viafb_active_dev=3DCRT+DVI viafb_dvi_port=3DDVP1
+                  viafb_mode1=3D1024x768 viafb_bpp=3D16 =
viafb_refresh1=3D60
+                  viafb_SAMM_ON=3D1
+
+    viafb_mode:
+        640x480 (default)
+        720x480
+        800x600
+        1024x768
+        ......
+
+    viafb_bpp:
+        8, 16, 32 (default:32)
+
+    viafb_refresh:
+        60, 75, 85, 100, 120 (default:60)
+
+    viafb_lcd_dsp_method:
+        0 : expansion (default)
+        1 : centering
+
+    viafb_lcd_mode:
+        0 : LCD panel with LSB data format input (default)
+        1 : LCD panel with MSB data format input
+
+    viafb_lcd_panel_id:
+        0 : Resolution: 640x480, Channel: single, Dithering: Enable
+        1 : Resolution: 800x600, Channel: single, Dithering: Enable
+        2 : Resolution: 1024x768, Channel: single, Dithering: Enable =
(default)
+        3 : Resolution: 1280x768, Channel: single, Dithering: Enable
+        4 : Resolution: 1280x1024, Channel: dual, Dithering: Enable
+        5 : Resolution: 1400x1050, Channel: dual, Dithering: Enable
+        6 : Resolution: 1600x1200, Channel: dual, Dithering: Enable
+
+        8 : Resolution: 800x480, Channel: single, Dithering: Enable
+        9 : Resolution: 1024x768, Channel: dual, Dithering: Enable
+        10: Resolution: 1024x768, Channel: single, Dithering: Disable
+        11: Resolution: 1024x768, Channel: dual, Dithering: Disable
+        12: Resolution: 1280x768, Channel: single, Dithering: Disable
+        13: Resolution: 1280x1024, Channel: dual, Dithering: Disable
+        14: Resolution: 1400x1050, Channel: dual, Dithering: Disable
+        15: Resolution: 1600x1200, Channel: dual, Dithering: Disable=20
+        16: Resolution: 1366x768, Channel: single, Dithering: Disable
+        17: Resolution: 1024x600, Channel: single, Dithering: Enable
+        18: Resolution: 1280x768, Channel: dual, Dithering: Enable
+        19: Resolution: 1280x800, Channel: single, Dithering: Enable
+  =20
+    viafb_accel:
+        0 : No 2D Hardware Acceleration
+        1 : 2D Hardware Acceleration (default)
+
+    viafb_SAMM_ON:
+        0 : viafb_SAMM_ON disable (default)
+        1 : viafb_SAMM_ON enable
+
+    viafb_mode1: (secondary display device)
+        640x480 (default)
+        720x480
+        800x600
+        1024x768
+        ... ...
+
+    viafb_bpp1: (secondary display device)
+        8, 16, 32 (default:32)
+
+    viafb_refresh1: (secondary display device)
+        60, 75, 85, 100, 120 (default:60)
+
+    viafb_active_dev:
+        This option is used to specify active devices.(CRT, DVI, =
CRT+LCD...)
+        DVI stands for DVI or HDMI, E.g., If you want to enable HDMI,
+        set viafb_active_dev=3DDVI. In SAMM case, the previous of
+        viafb_active_dev is primary device, and the following is
+        secondary device.
+
+        For example:
+        To enable one device, such as DVI only, we can use:
+            modprobe viafb viafb_active_dev=3DDVI
+        To enable two devices, such as CRT+DVI:
+            modprobe viafb viafb_active_dev=3DCRT+DVI;
+
+        For DuoView case, we can use:
+            modprobe viafb viafb_active_dev=3DCRT+DVI
+            OR
+            modprobe viafb viafb_active_dev=3DDVI+CRT...
+
+        For SAMM case:
+        If CRT is primary and DVI is secondary, we should use:
+            modprobe viafb viafb_active_dev=3DCRT+DVI =
viafb_SAMM_ON=3D1...
+        If DVI is primary and CRT is secondary, we should use:
+            modprobe viafb viafb_active_dev=3DDVI+CRT =
viafb_SAMM_ON=3D1...
+
+    viafb_display_hardware_layout:
+        This option is used to specify display hardware layout for =
CX700 chip.
+        1 : LCD only
+        2 : DVI only
+        3 : LCD+DVI (default)
+        4 : LCD1+LCD2 (internal + internal)
+        16: LCD1+ExternalLCD2 (internal + external)
+
+    viafb_second_size:
+        This option is used to set second device memory size(MB) in =
SAMM case.
+        The minimal size is 16.
+
+    viafb_platform_epia_dvi:
+        This option is used to enable DVI on EPIA - M
+        0 : No DVI on EPIA - M (default)
+        1 : DVI on EPIA - M
+
+    viafb_bus_width:
+        When using 24 - Bit Bus Width Digital Interface,
+        this option should be set.
+        12: 12-Bit LVDS or 12-Bit TMDS (default)
+        24: 24-Bit LVDS or 24-Bit TMDS
+
+    viafb_device_lcd_dualedge:
+        When using Dual Edge Panel, this option should be set.
+        0 : No Dual Edge Panel (default)
+        1 : Dual Edge Panel
+
+    viafb_video_dev:
+        This option is used to specify video output devices(CRT, DVI, =
LCD) for
+        duoview case.
+        For example:
+        To output video on DVI, we should use:
+            modprobe viafb viafb_video_dev=3DDVI...
+
+    viafb_lcd_port:
+        This option is used to specify LCD output port,
+        available values are "DVP0" "DVP1" "DFP_HIGHLOW" "DFP_HIGH" =
"DFP_LOW".
+        for external LCD + external DVI on CX700(External LCD is on =
DVP0),
+        we should use:
+            modprobe viafb viafb_lcd_port=3DDVP0...
+
+Notes:
+    1. CRT may not display properly for DuoView CRT & DVI display at
+       the "640x480" PAL mode with DVI overscan enabled.
+    2. SAMM stands for single adapter multi monitors. It is different =
from
+       multi-head since SAMM support multi monitor at driver layers, =
thus fbcon
+       layer doesn't even know about it; SAMM's second screen doesn't =
have a
+       device node file, thus a user mode application can't access it =
directly.
+       When SAMM is enabled, viafb_mode and viafb_mode1, viafb_bpp and
+       viafb_bpp1, viafb_refresh and viafb_refresh1 can be different.
+    3. When console is depending on viafbinfo1, dynamically change =
resolution
+       and bpp, need to call VIAFB specified ioctl interface =
VIAFB_SET_DEVICE
+       instead of calling common ioctl function FBIOPUT_VSCREENINFO =
since
+       viafb doesn't support multi-head well, or it will cause screen =
crush.
+    4. VX800 2D accelerator hasn't been supported in this driver yet. =
When
+       using driver on VX800, the driver will disable the acceleration =
funciton.
+       as default.
+     =20
+
+[Configure viafb with "fbset" tool]
+-----------------------------------
+    "fbset" is an inbox utility of Linux.
+    1. Inquire current viafb information, type,
+           # fbset -i
+
+    2. Set various resolutions and viafb_refresh rates,
+           # fbset <resolution-vertical_sync>
+
+       example,
+           # fbset "1024x768-75"
+       or
+           # fbset -g 1024 768 1024 768 32
+       Check the file "/etc/fb.modes" to find display modes available.
+
+    3. Set the color depth,
+           # fbset -depth <value>
+
+       example,
+           # fbset -depth 16
+
+[Bootup with viafb]:
+--------------------
+    Add the following line to your grub.conf:
+    append =3D =
"video=3Dviafb:viafb_mode=3D1024x768,viafb_bpp=3D32,viafb_refresh=3D85"
+=20


------_=_NextPart_001_01C8FC15.E1AAED9A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD><TITLE>[PATCH 1/13 v3] viafb: viafb.modes, viafb.txt</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.5512" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<P><FONT size=3D2>Correct the description of VX800 2D acceleration, the =
driver diables the acceleration<BR>function by defualt if you use VX800 =
chip.<BR>Correct via_fb_ to viafb_ and remove the Kconfig part in =
viafb.txt.<BR><BR>viafb.modes: supported mode table<BR>viafb.txt: =
documentation of viafb driver<BR><BR>Signed-off-by: Joseph Chan =
&lt;josephchan@via.com.tw&gt;<BR><BR>diff -Nurp =
a/Documentation/fb/viafb.modes b/Documentation/fb/viafb.modes<BR>--- =
a/Documentation/fb/viafb.modes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1970-01-01 =
08:00:00.000000000 +0800<BR>+++ =
b/Documentation/fb/viafb.modes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-07-22 =
02:07:29.000000000 +0800<BR>@@ -0,0 +1,870 =
@@<BR>+#<BR>+#<BR>+#&nbsp;&nbsp; These data are based on the CRTC =
parameters in<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIA =
Integration Graphics Chip<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (C) =
2004 VIA Technologies Inc.<BR>+#<BR>+<BR>+#<BR>+#&nbsp;&nbsp; 640x480, =
60 Hz, Non-Interlaced (25.175 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
640&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31.469 kHz&nbsp; 59.94 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.813 =
us&nbsp;&nbsp;&nbsp; 0.064 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; 2 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.636 us&nbsp;&nbsp;&nbsp; =
0.318&nbsp; =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 10 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.907 =
us&nbsp;&nbsp;&nbsp; 1.048&nbsp; =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 6 chars&nbsp;&nbsp;&nbsp;&nbsp; 33 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 25.422 =
us&nbsp;&nbsp; 15.253 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 80 chars&nbsp;&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.356 =
us&nbsp;&nbsp;&nbsp; 1.430 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 20 chars&nbsp;&nbsp;&nbsp; 45 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+<BR>+mode =
"640x480-60"<BR>+# D: 25.175 MHz, H: 31.469 kHz, V: 59.94 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 640 480 640 480 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 39722 48 16 33 10 96 2 endmode mode =
"480x640-60"<BR>+# D: 24.823 MHz, H: 39.780 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 480 640 480 640 32 timings 39722 72 =
24 19 1 48 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 640x480, 75 Hz, =
Non-Interlaced (31.50 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
640&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37.500 kHz&nbsp; 75.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.032 =
us&nbsp;&nbsp;&nbsp; 0.080 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.508 =
us&nbsp;&nbsp;&nbsp; 0.027 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.810 =
us&nbsp;&nbsp;&nbsp; 0.427 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 15 chars&nbsp;&nbsp;&nbsp; 16 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 20.317 =
us&nbsp;&nbsp; 12.800 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 80 chars&nbsp;&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.349 =
us&nbsp;&nbsp;&nbsp; 0.533 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 25 chars&nbsp;&nbsp;&nbsp; 20 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"640x480-75"<BR>+# D: 31.50 MHz, H: 37.500 kHz, V: 75.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 640 480 640 480 32 timings 31747 120 =
16 16 1 64 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 640x480, 85 Hz, =
Non-Interlaced (36.000 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
640&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; =
43.269 kHz&nbsp; 85.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.556 us&nbsp;&nbsp;&nbsp; 0.069 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 7 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 1.556 =
us&nbsp;&nbsp;&nbsp; 0.023 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 7 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.222 =
us&nbsp;&nbsp;&nbsp; 0.578 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 10 chars&nbsp;&nbsp;&nbsp; 25 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 17.778 =
us&nbsp;&nbsp; 11.093 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 80 chars&nbsp;&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.333 =
us&nbsp;&nbsp;&nbsp; 0.670 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 24 chars&nbsp;&nbsp;&nbsp; 29 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"640x480-85"<BR>+# D: 36.000 MHz, H: 43.269 kHz, V: 85.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 640 480 640 480 32 timings 27777 80 =
56 25 1 56 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 640x480, 100 Hz, =
Non-Interlaced (43.163 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
640&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50.900 kHz&nbsp; 100.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.483 =
us&nbsp;&nbsp;&nbsp; 0.058 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.927 =
us&nbsp;&nbsp;&nbsp; 0.019 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 5 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.409 =
us&nbsp;&nbsp;&nbsp; 0.475 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 13 chars&nbsp;&nbsp;&nbsp; 25 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 14.827 =
us&nbsp;&nbsp; 9.430 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 80 chars&nbsp;&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.819 =
us&nbsp;&nbsp;&nbsp; 0.570 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 26 chars&nbsp;&nbsp;&nbsp; 29 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"640x480-100"<BR>+# D: 43.163 MHz, H: 50.900 kHz, V: 100.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 640 480 640 480 32 timings 23168 104 =
40 25 1 64 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 640x480, 120 Hz, =
Non-Interlaced (52.406 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
640&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 61.800 kHz&nbsp; 120.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.221 =
us&nbsp;&nbsp;&nbsp; 0.048 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 =
chars&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.763 =
us&nbsp;&nbsp;&nbsp; 0.016 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 5 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.984 =
us&nbsp;&nbsp;&nbsp; 0.496 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 13 chars&nbsp;&nbsp;&nbsp; 31 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 12.212 =
us&nbsp;&nbsp; 7.767 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 80 chars&nbsp;&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.969 =
us&nbsp;&nbsp;&nbsp; 0.566 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 26 chars&nbsp;&nbsp;&nbsp; 35 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"640x480-120"<BR>+# D: 52.406 MHz, H: 61.800 kHz, V: 120.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 640 480 640 480 32 timings 19081 104 =
40 31 1 64 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 720x480, 60 Hz, =
Non-Interlaced (26.880 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
720&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30.000 kHz&nbsp; 60.241 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.679 =
us&nbsp;&nbsp;&nbsp; 0.099 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 9 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.595 =
us&nbsp;&nbsp;&nbsp; 0.033 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.274 =
us&nbsp;&nbsp;&nbsp; 0.462 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp; 14 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 26.786 =
us&nbsp;&nbsp; 16.000 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 90 chars&nbsp;&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.548 =
us&nbsp;&nbsp;&nbsp; 0.600 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 22 chars&nbsp;&nbsp;&nbsp; 18 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"720x480-60"<BR>+# D: 26.880 MHz, H: 30.000 kHz, V: 60.24 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 720 480 720 480 32 timings 37202 88 =
16 14 1 72 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 800x480, 60 Hz, =
Non-Interlaced (29.581 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp;&nbsp;&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
480<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; 29.892 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.704 =
us&nbsp;&nbsp;&nbsp; 100.604 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10 chars&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.541 =
us&nbsp;&nbsp;&nbsp; 33.535 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 =
chars&nbsp;&nbsp;&nbsp;&nbsp; 1 lines<BR>+#&nbsp;&nbsp; Back =
Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.245 us&nbsp;&nbsp;&nbsp; 435.949 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; =
13 lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 27.044 =
us&nbsp;&nbsp; 16.097 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100 chars&nbsp;&nbsp; 480 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.491 =
us&nbsp;&nbsp;&nbsp; 0.570 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24 chars&nbsp;&nbsp;&nbsp; =
17 lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"800x480-60"<BR>+# D: 29.500 MHz, H: 29.738 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 800 480 800 480 32 timings 33805 96 =
24 10 3 72 7 endmode<BR>+#<BR>+#&nbsp;&nbsp; 720x576, 60 Hz, =
Non-Interlaced (32.668 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
720&nbsp;&nbsp;&nbsp;&nbsp; 576<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35.820 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.204 =
us&nbsp;&nbsp;&nbsp; 0.083 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 9 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.735 =
us&nbsp;&nbsp;&nbsp; 0.027 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 3 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.939 =
us&nbsp;&nbsp;&nbsp; 0.459 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; 17 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 22.040 =
us&nbsp;&nbsp; 16.080 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 90 chars&nbsp;&nbsp;&nbsp; 476 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.877 =
us&nbsp;&nbsp;&nbsp; 0.586 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 24 chars&nbsp;&nbsp;&nbsp; 21 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"720x576-60"<BR>+# D: 32.668 MHz, H: 35.820 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 720 576 720 576 32 timings 30611 96 =
24 17 1 72 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 800x600, 60 Hz, =
Non-Interlaced (40.00 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37.879 kHz&nbsp; 60.32 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.200 =
us&nbsp;&nbsp;&nbsp; 0.106 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 16 chars&nbsp;&nbsp;&nbsp; 4 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 1.000 us&nbsp;&nbsp;&nbsp; 0.026 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 5 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.200 =
us&nbsp;&nbsp;&nbsp; 0.607 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp; 23 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 20.000 =
us&nbsp;&nbsp; 15.840 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 100 chars&nbsp;&nbsp; 600 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.400 us&nbsp;&nbsp;&nbsp; =
0.739 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 32 chars&nbsp;&nbsp;&nbsp; 28 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"800x600-60"<BR>+# D: 40.00 MHz, H: 37.879 kHz, V: 60.32 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 800 600 800 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 25000 88 40 23 1 128 4 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 800x600, 75 Hz, =
Non-Interlaced (49.50 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 46.875 kHz&nbsp; 75.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.616 =
us&nbsp;&nbsp;&nbsp; 0.064 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 10 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.323 us&nbsp;&nbsp;&nbsp; 0.021 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.232 =
us&nbsp;&nbsp;&nbsp; 0.448 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 20 chars&nbsp;&nbsp;&nbsp; 21 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 16.162 =
us&nbsp;&nbsp; 12.800 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 100 chars&nbsp;&nbsp; 600 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.172 us&nbsp;&nbsp;&nbsp; =
0.533 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 32 chars&nbsp;&nbsp;&nbsp; 25 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"800x600-75"<BR>+# D: 49.50 MHz, H: 46.875 kHz, V: 75.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 800 600 800 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 20203 160 16 21 1 80 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 800x600, 85 Hz, =
Non-Interlaced (56.25 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 53.674 kHz&nbsp; 85.061 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.138 =
us&nbsp;&nbsp;&nbsp; 0.056 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.569 =
us&nbsp;&nbsp;&nbsp; 0.019 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 4 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.702 =
us&nbsp;&nbsp;&nbsp; 0.503 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 19 chars&nbsp;&nbsp;&nbsp; 27 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 14.222 =
us&nbsp;&nbsp; 11.179 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 100 chars&nbsp;&nbsp; 600 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.409 us&nbsp;&nbsp;&nbsp; =
0.578 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 31 chars&nbsp;&nbsp;&nbsp; 31 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"800x600-85"<BR>+# D: 56.25 MHz, H: 53.674 kHz, V: 85.061 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 800 600 800 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 17777 152 32 27 1 64 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 800x600, 100 Hz, =
Non-Interlaced (67.50 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>+#&nbsp;&nbsp; Scan =
Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 62.500 kHz&nbsp; 100.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.948 =
us&nbsp;&nbsp;&nbsp; 0.064 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 4 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.000 =
us&nbsp;&nbsp;&nbsp; 0.112 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0 chars&nbsp;&nbsp;&nbsp;&nbsp; 7 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.200 =
us&nbsp;&nbsp;&nbsp; 0.224 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 27 chars&nbsp;&nbsp;&nbsp; 14 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 11.852 =
us&nbsp;&nbsp; 9.600 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 100 chars&nbsp;&nbsp; 600 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.148 us&nbsp;&nbsp;&nbsp; =
0.400 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 35 chars&nbsp;&nbsp;&nbsp; 25 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"800x600-100"<BR>+# D: 67.50 MHz, H: 62.500 kHz, V: 100.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 800 600 800 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 14667 216 0 14 7 64 4 hsync high vsync =
high endmode<BR>+#<BR>+#&nbsp;&nbsp; 800x600, 120 Hz, Non-Interlaced =
(83.950 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; =
77.160 kHz&nbsp; 120.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.048 us&nbsp;&nbsp;&nbsp; 0.039 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.667 us&nbsp;&nbsp;&nbsp; 0.013 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 7 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.715 =
us&nbsp;&nbsp;&nbsp; 0.507 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 18 chars&nbsp;&nbsp;&nbsp; 39 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 9.529 =
us&nbsp;&nbsp;&nbsp; 7.776 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 100 chars&nbsp;&nbsp; 600 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.431 us&nbsp;&nbsp;&nbsp; =
0.557 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 36 chars&nbsp;&nbsp;&nbsp; 43 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"800x600-120"<BR>+# D: 83.950 MHz, H: 77.160 kHz, V: 120.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 800 600 800 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 11912 144 56 39 1 88 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 848x480, 60 Hz, =
Non-Interlaced (31.490 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
848&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; =
29.820 kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.795 us&nbsp;&nbsp;&nbsp; 0.099 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.508 us&nbsp;&nbsp;&nbsp; 0.033 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.303 =
us&nbsp;&nbsp;&nbsp; 0.429 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 13 chars&nbsp;&nbsp;&nbsp; 13 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 26.929 =
us&nbsp;&nbsp; 16.097 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 106 chars&nbsp;&nbsp; 480 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.605 us&nbsp;&nbsp;&nbsp; =
0.570 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 26 chars&nbsp;&nbsp;&nbsp; 17 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"848x480-60"<BR>+# D: 31.500 MHz, H: 29.830 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 848 480 848 480 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 31746 104 24 12 3 80 5 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 856x480, 60 Hz, =
Non-Interlaced (31.728 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
856&nbsp;&nbsp;&nbsp;&nbsp; 480<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; =
29.820 kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.774 us&nbsp;&nbsp;&nbsp; 0.099 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.504 us&nbsp;&nbsp;&nbsp; 0.033 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.728 =
us&nbsp;&nbsp;&nbsp; 0.429 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 13 chars&nbsp;&nbsp;&nbsp; 13 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 26.979 =
us&nbsp;&nbsp; 16.097 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 107 chars&nbsp;&nbsp; 480 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.556 us&nbsp;&nbsp;&nbsp; =
0.570 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 26 chars&nbsp;&nbsp;&nbsp; 17 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"856x480-60"<BR>+# D: 31.728 MHz, H: 29.820 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 856 480 856 480 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 31518 104 16 13 1 88 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"960x600-60"<BR>+# D: 45.250 MHz, H: 37.212 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 960 600 960 600 32 timings 22099 128 =
32 15 3 96 6 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1000x600, 60 Hz, =
Non-Interlaced (48.068 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1000&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; =
37.320 kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.164 us&nbsp;&nbsp;&nbsp; 0.080 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 13 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.832 us&nbsp;&nbsp;&nbsp; 0.027 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 5 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.996 =
us&nbsp;&nbsp;&nbsp; 0.483 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 18 chars&nbsp;&nbsp;&nbsp; 18 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 20.804 =
us&nbsp;&nbsp; 16.077 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 125 chars&nbsp;&nbsp; 600 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.991 us&nbsp;&nbsp;&nbsp; =
0.589 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 36 chars&nbsp;&nbsp;&nbsp; 22 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1000x600-60"<BR>+# D: 48.068 MHz, H: 37.320 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1000 600 1000 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 20834 144 40 18 1 104 3 endmode mode =
"1024x576-60"<BR>+# D: 46.996 MHz, H: 35.820 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 576 1024 576 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 21278 144 40 17 1 104 3 endmode mode =
"1024x600-60"<BR>+# D: 48.964 MHz, H: 37.320 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 600 1024 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 20461 144 40 18 1 104 3 endmode mode =
"1088x612-60"<BR>+# D: 52.952 MHz, H: 38.040 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1088 612 1088 612 32 timings 18877 =
152 48 16 3 104 5 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1024x512, 60 Hz, =
Non-Interlaced (41.291 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024&nbsp;&nbsp;&nbsp; 512<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; 31.860 =
kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.519 us&nbsp;&nbsp;&nbsp; 0.094 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 13 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.775 us&nbsp;&nbsp;&nbsp; 0.031 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 4 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.294 =
us&nbsp;&nbsp;&nbsp; 0.465 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 17 chars&nbsp;&nbsp;&nbsp; 15 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 24.800 =
us&nbsp;&nbsp; 16.070 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 128 chars&nbsp;&nbsp; 512 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.587 us&nbsp;&nbsp;&nbsp; =
0.596 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 34 chars&nbsp;&nbsp;&nbsp; 19 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1024x512-60"<BR>+# D: 41.291 MHz, H: 31.860 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 512 1024 512 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 24218 126 32 15 1 104 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1024x600, 60 Hz, =
Non-Interlaced (48.875 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Horizontal&nbsp; Vertical<BR>+#&nbsp;&nbsp; =
Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37.252 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.128 =
us&nbsp;&nbsp;&nbsp; =
80.532us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 13 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; Front =
Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.818 =
us&nbsp;&nbsp;&nbsp;&nbsp; 26.844 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 =
chars&nbsp;&nbsp;&nbsp;&nbsp; 1 lines<BR>+#&nbsp;&nbsp; Back =
Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.946 =
us&nbsp;&nbsp;&nbsp; 483.192 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18 =
chars&nbsp;&nbsp;&nbsp; 18 lines<BR>+#&nbsp;&nbsp; Active =
Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20.951 =
us&nbsp;&nbsp; 16.697 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128 =
chars&nbsp;&nbsp; 622 lines<BR>+#&nbsp;&nbsp; Blank =
Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.893 =
us&nbsp;&nbsp;&nbsp; 0.591 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36 =
chars&nbsp;&nbsp;&nbsp; 22 lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; negative&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+#mode =
"1024x600-60"<BR>+#&nbsp;&nbsp;&nbsp;&nbsp; # D: 48.875 MHz, H: 37.252 =
kHz, V: 60.00 Hz<BR>+#&nbsp;&nbsp;&nbsp;&nbsp; geometry 1024 600 1024 =
600 32<BR>+#&nbsp;&nbsp;&nbsp; timings 20460&nbsp; 144 40 18 1 104&nbsp; =
3<BR>+# endmode<BR>+#<BR>+#&nbsp;&nbsp; 1024x768, 60 Hz, Non-Interlaced =
(65.00 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48.363 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.092 =
us&nbsp;&nbsp;&nbsp; 0.124 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 17 chars&nbsp;&nbsp;&nbsp; 6 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.369 us&nbsp;&nbsp;&nbsp; 0.062 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 3 chars&nbsp;&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.462 =
us&nbsp;&nbsp;&nbsp; 0.601 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 20 chars&nbsp;&nbsp;&nbsp; 29 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 15.754 =
us&nbsp;&nbsp; 15.880 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 128 chars&nbsp;&nbsp; 768 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.923 us&nbsp;&nbsp;&nbsp; =
0.786 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 40 chars&nbsp;&nbsp;&nbsp; 38 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1024x768-60"<BR>+# D: 65.00 MHz, H: 48.363 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 768 1024 768 32 timings 15385 =
160 24 29 3 136 6 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1024x768, 75 Hz, =
Non-Interlaced (78.75 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60.023 kHz&nbsp; 75.03 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.219 =
us&nbsp;&nbsp;&nbsp; 0.050 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.203 us&nbsp;&nbsp;&nbsp; 0.017 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.235 =
us&nbsp;&nbsp;&nbsp; 0.466 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 22 chars&nbsp;&nbsp;&nbsp; 28 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 13.003 =
us&nbsp;&nbsp; 12.795 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 128 chars&nbsp;&nbsp; 768 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.657 us&nbsp;&nbsp;&nbsp; =
0.533 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 36 chars&nbsp;&nbsp;&nbsp; 32 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1024x768-75"<BR>+# D: 78.75 MHz, H: 60.023 kHz, V: 75.03 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 768 1024 768 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 12699 176 16 28 1 96 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1024x768, 85 Hz, =
Non-Interlaced (94.50 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp; 68.677 kHz&nbsp; 85.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.016 us&nbsp;&nbsp;&nbsp; 0.044 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.508 us&nbsp;&nbsp;&nbsp; 0.015 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 6 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.201 =
us&nbsp;&nbsp;&nbsp; 0.524 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 26 chars&nbsp;&nbsp;&nbsp; 36 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 10.836 =
us&nbsp;&nbsp; 11.183 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 128 chars&nbsp;&nbsp; 768 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.725 us&nbsp;&nbsp;&nbsp; =
0.582 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 44 chars&nbsp;&nbsp;&nbsp; 40 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1024x768-85"<BR>+# D: 94.50 MHz, H: 68.677 kHz, V: 85.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 768 1024 768 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 10582 208 48 36 1 96 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1024x768, 100 Hz, =
Non-Interlaced (110.0 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79.023 kHz&nbsp; 99.78 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.800 =
us&nbsp;&nbsp;&nbsp; 0.101 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp; 8 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.000 us&nbsp;&nbsp;&nbsp; 0.000 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0 chars&nbsp;&nbsp;&nbsp;&nbsp; 0 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.545 =
us&nbsp;&nbsp;&nbsp; 0.202 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 35 chars&nbsp;&nbsp;&nbsp; 16 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 9.309 =
us&nbsp;&nbsp;&nbsp; 9.719 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 128 chars&nbsp;&nbsp; 768 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.345 us&nbsp;&nbsp;&nbsp; =
0.304 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 46 chars&nbsp;&nbsp;&nbsp; 24 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1024x768-100"<BR>+# D: 113.3 MHz, H: 79.023 kHz, V: 99.78 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1024 768 1024 768 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 8825 280 0 16 0 88 8 endmode mode =
"1152x720-60"<BR>+# D: 66.750 MHz, H: 44.859 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1152 720 1152 720 32 timings 14981 =
168 56 19 3 112 6 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1152x864, 75 Hz, =
Non-Interlaced (110.0 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1152&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 864<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75.137 kHz&nbsp; 74.99 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.309 =
us&nbsp;&nbsp;&nbsp; 0.106 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 18 chars&nbsp;&nbsp;&nbsp; 8 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.245 us&nbsp;&nbsp;&nbsp; 0.599 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 3 chars&nbsp;&nbsp;&nbsp;&nbsp; 45 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.282 =
us&nbsp;&nbsp;&nbsp; 1.132 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 18 chars&nbsp;&nbsp;&nbsp; 85 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 10.473 =
us&nbsp;&nbsp; 11.499 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 144 chars&nbsp;&nbsp; 864 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.836 us&nbsp;&nbsp;&nbsp; =
1.837 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 39 chars&nbsp;&nbsp;&nbsp; 138 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1152x864-75"<BR>+# D: 110.0 MHz, H: 75.137 kHz, V: 74.99 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1152 864 1152 864 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 9259 144 24 85 45 144 =
8<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1200x720-60"<BR>+# D: 70.184 MHz, H: 44.760 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1200 720 1200 720 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 14253 184 28 22 1 128 3 endmode mode =
"1280x600-60"<BR>+# D: 61.503 MHz, H: 37.320 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 600 1280 600 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 16260 184 28 18 1 128 3 endmode mode =
"1280x720-50"<BR>+# D: 60.466 MHz, H: 37.050 kHz, V: 50.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 720 1280 720 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 16538 176 48 17 1 128 3 endmode mode =
"1280x768-50"<BR>+# D: 65.178 MHz, H: 39.550 kHz, V: 50.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 768 1280 768 32 timings 15342 =
184 28 19 1 128 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x768, 60 Hz, =
Non-Interlaced (80.136 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; 47.700 =
kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.697 us&nbsp;&nbsp;&nbsp; 0.063 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 17 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.799 us&nbsp;&nbsp;&nbsp; 0.021 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.496 =
us&nbsp;&nbsp;&nbsp; 0.483 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 25 chars&nbsp;&nbsp;&nbsp; 23 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 15.973 =
us&nbsp;&nbsp; 16.101 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 768 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.992 us&nbsp;&nbsp;&nbsp; =
0.566 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 50 chars&nbsp;&nbsp;&nbsp; 27 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x768-60"<BR>+# D: 80.13 MHz, H: 47.700 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 768 1280 768 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 12480 200 48 23 1 126 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x800, 60 Hz, =
Non-Interlaced (83.375 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp; 800<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; 49.628 =
kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.631 us&nbsp;&nbsp;&nbsp; 60.450 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17 chars&nbsp;&nbsp;&nbsp; 3 =
lines<BR>+#&nbsp;&nbsp; Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.768 =
us&nbsp;&nbsp;&nbsp; 20.15 =
us<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 =
chars&nbsp;&nbsp;&nbsp;&nbsp; 1 lines<BR>+#&nbsp;&nbsp; Back =
Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.399 us&nbsp;&nbsp;&nbsp; 0.483 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25 chars&nbsp;&nbsp;&nbsp; =
24 lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 15.352 =
us&nbsp;&nbsp; 16.120 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 800 =
lines<BR>+#&nbsp;&nbsp; Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.798 =
us&nbsp;&nbsp;&nbsp; 0.564 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50 chars&nbsp;&nbsp;&nbsp; =
28 lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negtive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x800-60"<BR>+# D: 83.500 MHz, H: 49.702 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 800 1280 800 32 timings 11994 =
200 72 22 3 128 6 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x960, 60 Hz, =
Non-Interlaced (108.00 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp; 960<BR>+#&nbsp;&nbsp; Scan Frequency&nbsp; 60.000 =
kHz&nbsp; 60.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.037 us&nbsp;&nbsp;&nbsp; 0.050 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 14 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.889 us&nbsp;&nbsp;&nbsp; 0.017 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; 1 lines<BR>+#&nbsp;&nbsp; =
Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.889 us&nbsp;&nbsp;&nbsp; =
0.600 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 39 chars&nbsp;&nbsp;&nbsp; 36 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 11.852 =
us&nbsp;&nbsp; 16.000 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 960 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.815 us&nbsp;&nbsp;&nbsp; =
0.667 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 65 chars&nbsp;&nbsp;&nbsp; 40 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x960-60"<BR>+# D: 108.00 MHz, H: 60.000 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 960 1280 960 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 9259 312 96 36 1 112 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x1024, 60 Hz, =
Non-Interlaced (108.00 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 63.981 kHz&nbsp; 60.02 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.037 =
us&nbsp;&nbsp;&nbsp; 0.047 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 14 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.444 us&nbsp;&nbsp;&nbsp; 0.015 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 6 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.297 =
us&nbsp;&nbsp;&nbsp; 0.594 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 31 chars&nbsp;&nbsp;&nbsp; 38 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 11.852 =
us&nbsp;&nbsp; 16.005 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 1024 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.778 us&nbsp;&nbsp;&nbsp; =
0.656 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 51 chars&nbsp;&nbsp;&nbsp; 42 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x1024-60"<BR>+# D: 108.00 MHz, H: 63.981 kHz, V: 60.02 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 1024 1280 1024 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 9260 248 48 38 1 112 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x1024, 75 Hz, =
Non-Interlaced (135.00 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79.976 kHz&nbsp; 75.02 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.067 =
us&nbsp;&nbsp;&nbsp; 0.038 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 18 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.119 us&nbsp;&nbsp;&nbsp; 0.012 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 2 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.837 =
us&nbsp;&nbsp;&nbsp; 0.475 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 31 chars&nbsp;&nbsp;&nbsp; 38 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 9.481 =
us&nbsp;&nbsp;&nbsp; 12.804 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 1024 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.022 us&nbsp;&nbsp;&nbsp; =
0.525 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 51 chars&nbsp;&nbsp;&nbsp; 42 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x1024-75"<BR>+# D: 135.00 MHz, H: 79.976 kHz, V: 75.02 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 1024 1280 1024 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 7408 248 16 38 1 144 3 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x1024, 85 Hz, =
Non-Interlaced (157.50 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp; 91.146 kHz&nbsp; 85.02 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.016 us&nbsp;&nbsp;&nbsp; 0.033 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 20 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.406 us&nbsp;&nbsp;&nbsp; 0.011 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.422 =
us&nbsp;&nbsp;&nbsp; 0.483 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 28 chars&nbsp;&nbsp;&nbsp; 44 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 8.127 =
us&nbsp;&nbsp;&nbsp; 11.235 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 1024 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.844 us&nbsp;&nbsp;&nbsp; =
0.527 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 56 chars&nbsp;&nbsp;&nbsp; 48 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x1024-85"<BR>+# D: 157.50 MHz, H: 91.146 kHz, V: 85.02 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 1024 1280 1024 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 6349 224 64 44 1 160 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1440x900-60"<BR>+# D: 106.500 MHz, H: 55.935 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1440 900 1440 900 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 9390 232 80 25 3 152 =
6<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1440x900-75"<BR>+# D: 136.750 MHz, H: 70.635 kHz, V: 75.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1440 900 1440 900 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 7315 248 96 33 3 152 6 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1440x1050, 60 Hz, =
Non-Interlaced (125.10 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1440&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1050<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65.220 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.204 =
us&nbsp;&nbsp;&nbsp; 0.046 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 19 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.760 us&nbsp;&nbsp;&nbsp; 0.015 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 12 chars&nbsp;&nbsp;&nbsp; 1 lines<BR>+#&nbsp;&nbsp; =
Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.964 us&nbsp;&nbsp;&nbsp; =
0.495 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 31 chars&nbsp;&nbsp;&nbsp; 33 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 11.405 =
us&nbsp;&nbsp; 16.099 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 180 chars&nbsp;&nbsp; 1050 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.928 us&nbsp;&nbsp;&nbsp; =
0.567 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 62 chars&nbsp;&nbsp;&nbsp; 37 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1440x1050-60"<BR>+# D: 125.10 MHz, H: 65.220 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1440 1050 1440 1050 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 7993 248 96 33 1 152 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1600x900-60"<BR>+# D: 118.250 MHz, H: 55.990 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1600 900 1600 900 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 8415 256 88 26 3 168 5 endmode mode =
"1600x1024-60"<BR>+# D: 136.358 MHz, H: 63.600 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1600 1024 1600 1024 32 timings 7315 =
272 104 32 1 168 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1600x1200, 60 Hz, =
Non-Interlaced (156.00 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1200<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76.200 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.026 =
us&nbsp;&nbsp;&nbsp; 0.105 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 20 chars&nbsp;&nbsp;&nbsp; 8 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.205 us&nbsp;&nbsp;&nbsp; 0.131 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 4 chars&nbsp;&nbsp;&nbsp;&nbsp; 10 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.636 =
us&nbsp;&nbsp;&nbsp; 0.682 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 32 chars&nbsp;&nbsp;&nbsp; 52 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 10.256 =
us&nbsp;&nbsp; 15.748 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 200 chars&nbsp;&nbsp; 1200 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.872 us&nbsp;&nbsp;&nbsp; =
0.866 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 56 chars&nbsp;&nbsp;&nbsp; 66 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1600x1200-60"<BR>+# D: 156.00 MHz, H: 76.200 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1600 1200 1600 1200 32 timings 6172 =
256 32 52 10 160 8 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1600x1200, 75 Hz, =
Non-Interlaced (202.50 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1200<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp; 93.750 kHz&nbsp; 75.00 Hz<BR>+#&nbsp;&nbsp; Sync =
Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.948 us&nbsp;&nbsp;&nbsp; 0.032 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 24 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.316 us&nbsp;&nbsp;&nbsp; 0.011 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.501 =
us&nbsp;&nbsp;&nbsp; 0.491 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 38 chars&nbsp;&nbsp;&nbsp; 46 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 7.901 =
us&nbsp;&nbsp;&nbsp; 12.800 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 200 chars&nbsp;&nbsp; 1200 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.765 us&nbsp;&nbsp;&nbsp; =
0.533 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 70 chars&nbsp;&nbsp;&nbsp; 50 =
lines<BR>+#&nbsp;&nbsp; Polarity&nbsp;&nbsp;&nbsp; =
positive&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1600x1200-75"<BR>+# D: 202.50 MHz, H: 93.750 kHz, V: 75.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1600 1200 1600 1200 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 4938 304 64 46 1 192 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1680x1050-60"<BR>+# D: 146.250 MHz, H: 65.290 kHz, V: 59.954 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1680 1050 1680 1050 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 6814 280 104 30 3 176 =
6<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1680x1050-75"<BR>+# D: 187.000 MHz, H: 82.306 kHz, V: 74.892 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1680 1050 1680 1050 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 5348 296 120 40 3 176 =
6<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1792x1344-60"<BR>+# D: 202.975 MHz, H: 83.460 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1792 1344 1792 1344 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 4902 320 128 43 1 192 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1856x1392-60"<BR>+# D: 218.571 MHz, H: 86.460 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1856 1392 1856 1392 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 4577 336 136 45 1 200 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1920x1200-60"<BR>+# D: 193.250 MHz, H: 74.556 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1920 1200 1920 1200 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 5173 336 136 36 3 200 =
6<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1920x1440-60"<BR>+# D: 234.000 MHz, H:90.000 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1920 1440 1920 1440 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 4274 344 128 56 1 208 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"1920x1440-75"<BR>+# D: 297.000 MHz, H:112.500 kHz, V: 75.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1920 1440 1920 1440 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 3367 352 144 56 1 224 =
3<BR>+&nbsp;&nbsp;&nbsp; hsync high vsync high endmode mode =
"2048x1536-60"<BR>+# D: 267.250 MHz, H: 95.446 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 2048 1536 2048 1536 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 3742 376 152 49 3 224 4 hsync high =
vsync high endmode<BR>+#<BR>+#&nbsp;&nbsp; 1280x720, 60 Hz, =
Non-Interlaced (74.481 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1280&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 720<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44.760 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.826 =
us&nbsp;&nbsp;&nbsp; 67.024 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 17 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.752 us&nbsp;&nbsp;&nbsp; 22.341 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 7 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.578 =
us&nbsp;&nbsp;&nbsp; 491.510 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 24 chars&nbsp;&nbsp;&nbsp; 22 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 17.186 =
us&nbsp;&nbsp; 16.086 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 160 chars&nbsp;&nbsp; 720 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.156 us&nbsp;&nbsp;&nbsp; =
0.581 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 48 chars&nbsp;&nbsp;&nbsp; 26 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1280x720-60"<BR>+# D: 74.481 MHz, H: 44.760 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1280 720 1280 720 32 timings 13426 =
192 64 22 1 136 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1920x1080, 60 Hz, =
Non-Interlaced (172.798 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1920&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1080<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 67.080 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.204 =
us&nbsp;&nbsp;&nbsp; 44.723 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 26 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.694 us&nbsp;&nbsp;&nbsp; 14.908 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 15 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.898 =
us&nbsp;&nbsp;&nbsp; 506.857 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 41 chars&nbsp;&nbsp;&nbsp; 34 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 11.111 =
us&nbsp;&nbsp; 16.100 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 240 chars&nbsp;&nbsp; 1080 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.796 us&nbsp;&nbsp;&nbsp; =
0.566 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 82 chars&nbsp;&nbsp;&nbsp; 38 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; negative<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1920x1080-60"<BR>+# D: 74.481 MHz, H: 67.080 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1920 1080 1920 1080 32 timings 5787 =
328 120 34 1 208 3 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1400x1050, 60 Hz, =
Non-Interlaced (122.61 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1050<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65.218 kHz&nbsp; 59.99 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.037 =
us&nbsp;&nbsp;&nbsp; 0.047 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 19 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.444 us&nbsp;&nbsp;&nbsp; 0.015 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 11 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.185 =
us&nbsp;&nbsp;&nbsp; 0.188 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 30 chars&nbsp;&nbsp;&nbsp; 33 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 12.963 =
us&nbsp;&nbsp; 16.411 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 175 chars&nbsp;&nbsp; 1050 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.667 us&nbsp;&nbsp;&nbsp; =
0.250 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 60 chars&nbsp;&nbsp;&nbsp; 37 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1400x1050-60"<BR>+# D: 122.750 MHz, H: 65.317 kHz, V: 59.99 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1400 1050 1408 1050 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 8214 232 88 32 3 144 4 endmode mode =
"1400x1050-75"<BR>+# D: 156.000 MHz, H: 82.278 kHz, V: 74.867 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1400 1050 1408 1050 32 timings 6410 =
248 104 42 3 144 4 endmode<BR>+#<BR>+#&nbsp;&nbsp; 1366x768, 60 Hz, =
Non-Interlaced (85.86 MHz =
dotclock)<BR>+#<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Horizontal&nbsp; =
Vertical<BR>+#&nbsp;&nbsp; Resolution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1366&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 768<BR>+#&nbsp;&nbsp; =
Scan Frequency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47.700 kHz&nbsp; 60.00 =
Hz<BR>+#&nbsp;&nbsp; Sync Width&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.677 =
us&nbsp;&nbsp;&nbsp; 0.063 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 18 chars&nbsp;&nbsp;&nbsp; 3 lines<BR>+#&nbsp;&nbsp; =
Front Porch&nbsp;&nbsp;&nbsp;&nbsp; 0.839 us&nbsp;&nbsp;&nbsp; 0.021 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 9 chars&nbsp;&nbsp;&nbsp;&nbsp; 1 =
lines<BR>+#&nbsp;&nbsp; Back Porch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.516 =
us&nbsp;&nbsp;&nbsp; 0.482 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 27 chars&nbsp;&nbsp;&nbsp; 23 =
lines<BR>+#&nbsp;&nbsp; Active Time&nbsp;&nbsp;&nbsp;&nbsp; 15.933 =
us&nbsp;&nbsp; 16.101 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 171 chars&nbsp;&nbsp; 768 lines<BR>+#&nbsp;&nbsp; =
Blank Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.031 us&nbsp;&nbsp;&nbsp; =
0.566 =
ms<BR>+#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 54 chars&nbsp;&nbsp;&nbsp; 27 =
lines<BR>+#&nbsp;&nbsp; =
Polarity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negative&nbsp;&nbsp;&nbsp; positive<BR>+#<BR>+&nbsp;&nbsp;&nbsp; mode =
"1360x768-60"<BR>+# D: 84.750 MHz, H: 47.720 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1360 768 1360 768 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 11799 208 72 22 3 136 5 endmode mode =
"1366x768-60"<BR>+# D: 85.86 MHz, H: 47.700 kHz, V: 60.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1366 768 1366 768 =
32<BR>+&nbsp;&nbsp;&nbsp; timings 11647 216 72 23 1 144 3 endmode mode =
"1366x768-50"<BR>+# D: 69,924 MHz, H: 39.550 kHz, V: 50.00 =
Hz<BR>+&nbsp;&nbsp;&nbsp; geometry 1366 768 1366 768 32 timings 14301 =
200 56 19 1 144 3 endmode<BR>diff -Nurp a/Documentation/fb/viafb.txt =
b/Documentation/fb/viafb.txt<BR>--- =
a/Documentation/fb/viafb.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1970-01-01 08:00:00.000000000 +0800<BR>+++ =
b/Documentation/fb/viafb.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2008-08-11 04:01:43.000000000 +0800<BR>@@ -0,0 +1,214 =
@@<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIA Integration =
Graphic Chip Console Framebuffer =
Driver<BR>+<BR>+[Platform]<BR>+-----------------------<BR>+&nbsp;&nbsp;&n=
bsp; The console framebuffer driver is for graphics chips =
of<BR>+&nbsp;&nbsp;&nbsp; VIA UniChrome Family(CLE266, PM800 / CN400 / =
CN300,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; P4M800CE / P4M800Pro / CN700 / =
VN800,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; CX700 / VX700, K8M890, =
P4M890,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; CN896 / P4M900, VX800)<BR>+<BR>+[Driver =
features]<BR>+------------------------<BR>+&nbsp;&nbsp;&nbsp; Device: =
CRT, LCD, DVI<BR>+<BR>+&nbsp;&nbsp;&nbsp; Support =
viafb_mode:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CRT:&nbsp;&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 640x480(60, 75, 85, 100, 120 Hz), 720x480(60 =
Hz),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 720x576(60 Hz), 800x600(60, 75, 85, 100, 120 =
Hz),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 848x480(60 Hz), 856x480(60 Hz), 1024x512(60 =
Hz),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1024x768(60, 75, 85, 100 Hz), 1152x864(75 =
Hz),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1280x768(60 Hz), 1280x960(60 Hz), 1280x1024(60, 75, 85 =
Hz),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1440x1050(60 Hz), 1600x1200(60, 75 Hz), 1280x720(60 =
Hz),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1920x1080(60 Hz), 1400x1050(60 Hz), 800x480(60 =
Hz)<BR>+<BR>+&nbsp;&nbsp;&nbsp; color depth: 8 bpp, 16 bpp, 32 bpp =
supports.<BR>+<BR>+&nbsp;&nbsp;&nbsp; Support 2D hardware =
accelerator.<BR>+<BR>+[Using the viafb module]<BR>+-- -- =
--------------------<BR>+&nbsp;&nbsp;&nbsp; Start viafb with default =
settings:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #modprobe =
viafb<BR>+<BR>+&nbsp;&nbsp;&nbsp; Start viafb with with user =
options:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #modprobe viafb =
viafb_mode=3D800x600 viafb_bpp=3D16 =
viafb_refresh=3D60<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viafb_active_dev=3DCRT+DVI =
viafb_dvi_port=3DDVP1<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viafb_mode1=3D1024x768 viafb_bpp=3D16 =
viafb_refresh1=3D60<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viafb_SAMM_ON=3D1<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_mode:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 640x480 =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
720x480<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800x600<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024x768<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
......<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_bpp:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8, 16, 32 =
(default:32)<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_refresh:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60, 75, =
85, 100, 120 (default:60)<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_lcd_dsp_method:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : =
expansion (default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : =
centering<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_lcd_mode:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : LCD =
panel with LSB data format input =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : LCD panel =
with MSB data format input<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_lcd_panel_id:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : =
Resolution: 640x480, Channel: single, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : Resolution: =
800x600, Channel: single, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 : Resolution: =
1024x768, Channel: single, Dithering: Enable =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 : Resolution: =
1280x768, Channel: single, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 : Resolution: =
1280x1024, Channel: dual, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 : Resolution: =
1400x1050, Channel: dual, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6 : Resolution: =
1600x1200, Channel: dual, Dithering: =
Enable<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 : =
Resolution: 800x480, Channel: single, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9 : Resolution: =
1024x768, Channel: dual, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Resolution: =
1024x768, Channel: single, Dithering: =
Disable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Resolution: =
1024x768, Channel: dual, Dithering: =
Disable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12: Resolution: =
1280x768, Channel: single, Dithering: =
Disable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13: Resolution: =
1280x1024, Channel: dual, Dithering: =
Disable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14: Resolution: =
1400x1050, Channel: dual, Dithering: =
Disable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15: Resolution: =
1600x1200, Channel: dual, Dithering: =
Disable&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16: =
Resolution: 1366x768, Channel: single, Dithering: =
Disable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17: Resolution: =
1024x600, Channel: single, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18: Resolution: =
1280x768, Channel: dual, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19: Resolution: =
1280x800, Channel: single, Dithering: =
Enable<BR>+&nbsp;&nbsp;&nbsp;<BR>+&nbsp;&nbsp;&nbsp; =
viafb_accel:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : No 2D =
Hardware Acceleration<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : =
2D Hardware Acceleration (default)<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_SAMM_ON:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : =
viafb_SAMM_ON disable =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : =
viafb_SAMM_ON enable<BR>+<BR>+&nbsp;&nbsp;&nbsp; viafb_mode1: (secondary =
display device)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 640x480 =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
720x480<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
800x600<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024x768<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ... =
...<BR>+<BR>+&nbsp;&nbsp;&nbsp; viafb_bpp1: (secondary display =
device)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8, 16, 32 =
(default:32)<BR>+<BR>+&nbsp;&nbsp;&nbsp; viafb_refresh1: (secondary =
display device)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60, 75, =
85, 100, 120 (default:60)<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_active_dev:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This =
option is used to specify active devices.(CRT, DVI, =
CRT+LCD...)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DVI stands =
for DVI or HDMI, E.g., If you want to enable =
HDMI,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set =
viafb_active_dev=3DDVI. In SAMM case, the previous =
of<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viafb_active_dev is =
primary device, and the following =
is<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; secondary =
device.<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; For =
example:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To enable one =
device, such as DVI only, we can =
use:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; modprobe viafb =
viafb_active_dev=3DDVI<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To =
enable two devices, such as =
CRT+DVI:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; modprobe viafb =
viafb_active_dev=3DCRT+DVI;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; For DuoView case, we can =
use:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; modprobe viafb =
viafb_active_dev=3DCRT+DVI<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
OR<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 modprobe viafb =
viafb_active_dev=3DDVI+CRT...<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; For SAMM case:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
If CRT is primary and DVI is secondary, we should =
use:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; modprobe viafb viafb_active_dev=3DCRT+DVI =
viafb_SAMM_ON=3D1...<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If =
DVI is primary and CRT is secondary, we should =
use:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; modprobe viafb viafb_active_dev=3DDVI+CRT =
viafb_SAMM_ON=3D1...<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_display_hardware_layout:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; This option is used to specify display hardware layout for CX700 =
chip.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : LCD =
only<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 : DVI =
only<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 : LCD+DVI =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 : LCD1+LCD2 =
(internal + internal)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16: =
LCD1+ExternalLCD2 (internal + external)<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_second_size:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This =
option is used to set second device memory size(MB) in SAMM =
case.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The minimal size is =
16.<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_platform_epia_dvi:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
This option is used to enable DVI on EPIA - =
M<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : No DVI on EPIA - M =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : DVI on EPIA =
- M<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_bus_width:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When =
using 24 - Bit Bus Width Digital =
Interface,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this option =
should be set.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12: 12-Bit =
LVDS or 12-Bit TMDS =
(default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24: 24-Bit LVDS =
or 24-Bit TMDS<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_device_lcd_dualedge:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 When using Dual Edge Panel, this option should be =
set.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : No Dual Edge =
Panel (default)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 : Dual =
Edge Panel<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_video_dev:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This =
option is used to specify video output devices(CRT, DVI, LCD) =
for<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duoview =
case.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; For =
example:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To output video =
on DVI, we should =
use:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; modprobe viafb viafb_video_dev=3DDVI...<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
viafb_lcd_port:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This =
option is used to specify LCD output =
port,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; available values =
are "DVP0" "DVP1" "DFP_HIGHLOW" "DFP_HIGH" =
"DFP_LOW".<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for external =
LCD + external DVI on CX700(External LCD is on =
DVP0),<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; we should =
use:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; modprobe viafb =
viafb_lcd_port=3DDVP0...<BR>+<BR>+Notes:<BR>+&nbsp;&nbsp;&nbsp; 1. CRT =
may not display properly for DuoView CRT &amp; DVI display =
at<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the "640x480" PAL mode with =
DVI overscan enabled.<BR>+&nbsp;&nbsp;&nbsp; 2. SAMM stands for single =
adapter multi monitors. It is different =
from<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multi-head since SAMM =
support multi monitor at driver layers, thus =
fbcon<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; layer doesn't even know =
about it; SAMM's second screen doesn't have =
a<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device node file, thus a user =
mode application can't access it =
directly.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When SAMM is enabled, =
viafb_mode and viafb_mode1, viafb_bpp =
and<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viafb_bpp1, viafb_refresh =
and viafb_refresh1 can be different.<BR>+&nbsp;&nbsp;&nbsp; 3. When =
console is depending on viafbinfo1, dynamically change =
resolution<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and bpp, need to =
call VIAFB specified ioctl interface =
VIAFB_SET_DEVICE<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instead of =
calling common ioctl function FBIOPUT_VSCREENINFO =
since<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viafb doesn't support =
multi-head well, or it will cause screen crush.<BR>+&nbsp;&nbsp;&nbsp; =
4. VX800 2D accelerator hasn't been supported in this driver yet. =
When<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; using driver on VX800, the =
driver will disable the acceleration =
funciton.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as =
default.<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>+<BR>+[Configure =
viafb with "fbset" =
tool]<BR>+-----------------------------------<BR>+&nbsp;&nbsp;&nbsp; =
"fbset" is an inbox utility of Linux.<BR>+&nbsp;&nbsp;&nbsp; 1. Inquire =
current viafb information, =
type,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # =
fbset -i<BR>+<BR>+&nbsp;&nbsp;&nbsp; 2. Set various resolutions and =
viafb_refresh =
rates,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
# fbset =
&lt;resolution-vertical_sync&gt;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
example,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 # fbset "1024x768-75"<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
or<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # =
fbset -g 1024 768 1024 768 32<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Check the file "/etc/fb.modes" to find display modes =
available.<BR>+<BR>+&nbsp;&nbsp;&nbsp; 3. Set the color =
depth,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
# fbset -depth =
&lt;value&gt;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
example,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 # fbset -depth 16<BR>+<BR>+[Bootup with =
viafb]:<BR>+--------------------<BR>+&nbsp;&nbsp;&nbsp; Add the =
following line to your grub.conf:<BR>+&nbsp;&nbsp;&nbsp; append =3D =
"video=3Dviafb:viafb_mode=3D1024x768,viafb_bpp=3D32,viafb_refresh=3D85"<B=
R>+</FONT> </P></BODY></HTML>
------_=_NextPart_001_01C8FC15.E1AAED9A--


--===============1578662951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1578662951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1578662951==--
