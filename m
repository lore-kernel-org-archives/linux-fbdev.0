From: Chris Ball <cjb@laptop.org>
Date: Sun, 13 Mar 2011 16:07:42 +0000
Subject: Re: [PATCH 1/4] viafb: kill lcd_panel_id
Message-Id: <m3hbb7xaup.fsf@pullcord.laptop.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>
	<1299964979-3391-2-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1299964979-3391-2-git-send-email-FlorianSchandinat@gmx.de>
	(Florian Tobias Schandinat's message of "Sat, 12 Mar 2011 21:22:56
	+0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Florian,

On Sat, Mar 12 2011, Florian Tobias Schandinat wrote:
> This patch removes all internal uses of another mostly artificial
> value. It does duplicate the information of the maximum resolution and
> it is not flexible as only a few resolutions exist. Hence it is better
> to remove it and clean the mess up.
> No runtime change expected.
>
> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

We're passing viafb_lcd_panel_id at boot-time on OLPC XO-1.5.
Won't this break boot for us, and anyone else who needs to use it?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
