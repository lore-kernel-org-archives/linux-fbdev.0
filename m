From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Jun 2013 17:28:22 +0000
Subject: imx-drm does not report correct info in fbset
Message-Id: <CAOMZO5A=JSHJrkXwXkYYxbkjtcFv3NU5W6F4hSb5Y7ZrpKij=A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Philipp/Sascha,

When I enable the parallel display on a mx53qsb, I noticed that fbset
does not report the correct information:

mode "800x480-0"
        # D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
        geometry 800 480 800 480 16
        timings 0 0 0 0 0 0 0
        accel true
        rgba 5/11,6/5,5/0,0/0
endmode

I haven't started debugging this, but just would like to check if this
is a known issue with the imx-drm driver.

Thanks,

Fabio Estevam
