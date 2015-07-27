From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 27 Jul 2015 05:36:41 +0000
Subject: Re: [PATCH] sm750fb: coding style fixes lines over 80 chars
Message-Id: <20150727052441.GG3985@sudip-pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437118085-8432-1-git-send-email-simhavcs@gmail.com>
 <1437118721.2495.54.camel@perches.com>
 <CAGWqDJ4dgrsYAiWXMKi2j1-kGoFhQ_rZGxuDuqpbfTG2P7bnsw@mail.gmail.com>
In-Reply-To: <CAGWqDJ4dgrsYAiWXMKi2j1-kGoFhQ_rZGxuDuqpbfTG2P7bnsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinay Simha <simhavcs@gmail.com>
Cc: Joe Perches <joe@perches.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, open list <linux-kernel@vger.kernel.org>

On Tue, Jul 21, 2015 at 03:17:06PM +0530, Vinay Simha wrote:
> Joe,
> 
> Just want to confirm, shall i delete this code in sm750_help.h, even the
> FIELD_START and FIELD_END is not required.
If they are not used anywhere feel free to send a patch to delete them.

regards
sudip
