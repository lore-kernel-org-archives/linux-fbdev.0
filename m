From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 11 Jan 2011 03:04:25 +0000
Subject: Re: [PATCH] Drivers: video: Add modes for Devkit8000 displays
Message-Id: <20110111030425.GG3760@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294673672-30924-1-git-send-email-weber@corscience.de>
In-Reply-To: <1294673672-30924-1-git-send-email-weber@corscience.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Weber <weber@corscience.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 10, 2011 at 04:34:32PM +0100, Thomas Weber wrote:
> This patch adds the video modes for the 4.3, 5.6 and 7 inch panels that
> are sold with the devkit8000.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>

The modedb is primarily intended for generic modes that are going to be
used by a multiple of drivers. If you're simply dealing with modes for
panels for a one-off board that no one else is using, then simply keep it
local to the driver. If there are multiple users of the same modes, then
it's of course possible to make it generally available.
