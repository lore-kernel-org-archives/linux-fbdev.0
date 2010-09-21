From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 21 Sep 2010 20:31:16 +0000
Subject: Re: [PATCH] viafb: Use proper register for bgcolor when doing MONO
Message-Id: <4C991614.4080504@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921154604.2E3059D401B@zog.reactivated.net>
In-Reply-To: <20100921154604.2E3059D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Jon Nettleton schrieb:
> On Tue, Sep 21, 2010 at 10:07 AM, Daniel Drake <dsd@laptop.org> wrote:
>> On 21 September 2010 18:00, Florian Tobias Schandinat
>> <FlorianSchandinat@gmx.de> wrote:
>>> Not really. For color blits it looks like we're doing the right thing here,
> Yes you are but the code says.
> 
>  if (op = VIA_BITBLT_MONO)

I wrote a little test case:
 >>> colortest.sh
#!/bin/sh

echo -e "\033[30;47mblit: BLACK_ON_WHITE\033[0m"
echo -e "\033[37;40mblit: WHITE_ON_BLACK\033[0m"
echo -e "\033[31;44mbilt: RED_ON_BLUE\033[0m"
echo -e "fillrect: YELLOW\033[43m"
sleep 5
clear
echo -e "\033[0m"
<<<
The first three cases behaved on VX800 as well as XO 1.5 (with stock kernel as 
well as self-compiled) as expected, only the last went wrong (the cleared 
background was black instead yellow). Yes that is a bug but nut anything in the 
blitting code but in the VIA_BITBLT_FILL code where I admit that we write the 
colour to the wrong register. Will try to get a proper patch for that in the 
next few days (although I'm very, very busy at the moment).


Thanks,

Florian Tobias Schandinat

