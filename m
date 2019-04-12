From: Petr Mladek <pmladek@suse.com>
Date: Fri, 12 Apr 2019 13:48:02 +0000
Subject: Re: [PATCH 1/4] lib/hexdump.c: Allow 64 bytes per line
Message-Id: <20190412134802.kprel2c2iqijd4ai@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190410031720.11067-1-alastair@au1.ibm.com>
 <20190410031720.11067-2-alastair@au1.ibm.com>
In-Reply-To: <20190410031720.11067-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: alastair@d-silva.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Karsten Keil <isdn@linux-pingi.de>, Jassi Brar <jassisinghbrar@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, "David S. Miller" <davem@davemloft.net>, Jose Abreu <Jose.Abreu@synopsys.com>, Kalle Valo <kvalo@codeaurora.org>, Stanislaw Gruszka <sgruszka@redhat.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.>

On Wed 2019-04-10 13:17:17, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> With modern high resolution screens, we can display more data, which makes
> life a bit easier when debugging.

I have quite some doubts about this feature.

We are talking about more than 256 characters per-line. I wonder
if such a long line is really easier to read for a human.

I am not expert but there is a reason why the standard is 80
characters per-line. I guess that anything above 100 characters
is questionable. https://en.wikipedia.org/wiki/Line_length
somehow confirms that.

Second, if we take 8 pixels per-character. Then we need
2048 to show the 256 characters. It is more than HD.
IMHO, there is still huge number of people that even do
not have HD display, especially on a notebook.


I am sorry but I am strongly against having this hardcoded
anywhere. And I doubt that there will be enough users
to complicate the code and make it configurable.

Best Regards,
Petr
