From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Thu, 30 May 2013 14:05:55 +0000
Subject: Re: [PATCH 1/8] video: atmel_lcdfb: fix platform data struct
Message-Id: <20130530140555.GA10370@samfundet.no>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <CACQ1gAjF5kuu-czkj56-pQdTBUhvY5VodvfnF3RA_DN-O0b9NQ@mail.gmail.com>
 <20130529173538.GC23899@game.jcrosoft.org>
 <CACQ1gAhhsMw1-Znd8BC=A0rJBrB4pphCtH9v9qOQR+j2dY3vCw@mail.gmail.com>
 <20130529193220.GB19468@game.jcrosoft.org>
 <CACQ1gAj_m_aWaq5J41SY8EPwOH5-3zYPsf2WJCunvVnBCyq00Q@mail.gmail.com>
 <20130530072328.GE19468@game.jcrosoft.org>
In-Reply-To: <20130530072328.GE19468@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Around Thu 30 May 2013 09:23:28 +0200 or thereabout, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 08:39 Thu 30 May     , Richard Genoud wrote:
>> 2013/5/29 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>> > On 19:44 Wed 29 May     , Richard Genoud wrote:
>> >> 2013/5/29 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>> >> > On 16:36 Wed 29 May     , Richard Genoud wrote:
>> >> >> 2013/4/11 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:

<snipp diff>

>> >> >> > +       bool                    lcdcon_pol_negative;
>> >> >> I think lcdcon_pol_negative should be part of pdata, because it really
>> >> >> depends on how the PWM is wired on the board.
>> >> >>
>> >> >
>> >> > maybe but no one mainline use it on any pdata for non-dt boars
>> >> > so I did not want to expose it
>> >> Well, at least, I'm using it :)
>> >> (and I guess that Andreas is using it also, otherwise he wouldn't have
>> >> introduce it !)
>> >
>> > yes but pdata is for non-dt boards, for dt you can keep it in struct
>> > atmel_lcdfb_info and add a property
>> >
>> > if non-dt boards want it my answer is I do not care switch to DT
>> 
>> ok (I use a full DT board based on sam9g35)
>> 
>> so I'll add something like
>> sinfo->lcdcon_pol_negative = of_property_read_bool(display_np,
>> "atmel,lcdcon-pwm-pulse-low");
>> in /atmel_lcdfb.c
>> 
>> But I thought the goal of this patch was to separate driver data from
>> platform specific data, and IMHO, lcdcon_pol_negative is a specificity
>> of the platform.
> 
> You are right but as non one mainline use it as pdata I choose to drop it
> and only keep it on the driver as we can still use it for DT
>
> It's a way to force peopoe to switch to DT

FYI AVR32 architecture doesn't support device tree, nor is it likely to do
so. However there are no users of the PWM output from the LCDC block for the
boards in the current kernel, and I doubt new boards will pop.

-- 
Hans-Christian Egtvedt
