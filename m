From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Tue, 26 Jan 2016 20:36:50 +0000
Subject: Re: [PATCH resend] ocfb: fix tgdel and tvdel timing parameters
Message-Id: <20160126203649.GA29694@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453819684-32742-1-git-send-email-andrea.merello@gmail.com>
In-Reply-To: <1453819684-32742-1-git-send-email-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jan 26, 2016 at 03:48:04PM +0100, Andrea Merello wrote:
> According to the ocfb documentation:
> Fix tgdel HW param should be left margin, not right.
> Fix tvdel HW param should upper margin, not lower.
> 
> This seems to fix lock issues on certain monitors (tested on a
> slightly customized IP, but the FPGA guy said that it should
> be the same wrt this changes).
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

I don't have a hardware setup at the moment to test this,
but you are right about the ocfb documentation and looking at the rtl,
it seems right.

Acked-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
