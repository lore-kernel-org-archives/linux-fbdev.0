From: vijay singh <testmrs.evo@gmail.com>
Date: Fri, 07 Jan 2011 12:16:08 +0000
Subject: Accessing FB struct
Message-Id: <1294401848.30505.8.camel@vijay-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,
Is their any api available under Xlib which can give me information of
frame buffer struct (mentioned below).

struct fb_buffer_info {
        u8      bpp ;
        u8      num_buffers ;
        enum    color_mode mode ;
        u32     height ;
        u32     width ;
        u32     stride ;
        struct
        fbbuffer_addr   buffer_address[NUM_FB_BUFFERS];
};

or what is way to get data available under above struct.

Cheers--
Vij

