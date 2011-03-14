From: Chris Ball <cjb@laptop.org>
Date: Mon, 14 Mar 2011 00:05:13 +0000
Subject: Re: [PATCH 1/4] viafb: kill lcd_panel_id
Message-Id: <m3zkoywoqu.fsf@pullcord.laptop.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>
	<1299964979-3391-2-git-send-email-FlorianSchandinat@gmx.de>
	<m3hbb7xaup.fsf@pullcord.laptop.org> <4D7CFBC7.2060109@gmx.de>
In-Reply-To: <4D7CFBC7.2060109@gmx.de> (Florian Tobias Schandinat's message of
	"Sun, 13 Mar 2011 18:15:51 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Florian,

On Sun, Mar 13 2011, Florian Tobias Schandinat wrote:
> No need to worry. The external interface is kept for compatibility,
> only the internal uses are replace by panel hres/vres which contain
> the same information but are more generic.
>
> I have not yet tested it on OLPC as I did not have the time to compile
> a new kernel for it, but as it works on my VX900 laptop which also
> uses the viafb_lcd_panel_id setting it should be fine.

Thanks, this makes sense; the patch looks fine, then.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
