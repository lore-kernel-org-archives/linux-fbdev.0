From: Timur Tabi <timur@tabi.org>
Date: Thu, 17 Jan 2013 23:01:03 +0000
Subject: Re: [PATCH 1/2] drivers/video: fsl-diu-fb: fix pixel formats for 24 and 16 bpp
Message-Id: <50F882AF.9000004@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358454518-14032-1-git-send-email-agust@denx.de>
In-Reply-To: <1358454518-14032-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anatolij Gustschin wrote:
> No, my patch doesn't break it. The patch also modifies the order of
> red, blue, green arguments in the MAKE_PF() macro to red, green, blue
> order since this is more natural:

I'm sorry, I don't know why I didn't notice that.

-- 
Timur Tabi
