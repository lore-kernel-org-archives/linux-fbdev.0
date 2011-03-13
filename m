From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 Mar 2011 17:15:51 +0000
Subject: Re: [PATCH 1/4] viafb: kill lcd_panel_id
Message-Id: <4D7CFBC7.2060109@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299964979-3391-1-git-send-email-FlorianSchandinat@gmx.de>	<1299964979-3391-2-git-send-email-FlorianSchandinat@gmx.de> <m3hbb7xaup.fsf@pullcord.laptop.org>
In-Reply-To: <m3hbb7xaup.fsf@pullcord.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chris,

Chris Ball schrieb:
> Hi Florian,
> 
> On Sat, Mar 12 2011, Florian Tobias Schandinat wrote:
>> This patch removes all internal uses of another mostly artificial
>> value. It does duplicate the information of the maximum resolution and
>> it is not flexible as only a few resolutions exist. Hence it is better
>> to remove it and clean the mess up.
>> No runtime change expected.
>>
>> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> 
> We're passing viafb_lcd_panel_id at boot-time on OLPC XO-1.5.
> Won't this break boot for us, and anyone else who needs to use it?

No need to worry. The external interface is kept for compatibility, only the 
internal uses are replace by panel hres/vres which contain the same information 
but are more generic.
I have not yet tested it on OLPC as I did not have the time to compile a new 
kernel for it, but as it works on my VX900 laptop which also uses the 
viafb_lcd_panel_id setting it should be fine.


Thanks,

Florian Tobias Schandinat

