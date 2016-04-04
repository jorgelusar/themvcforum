﻿using System.Collections.Generic;
using MVCForum.Domain.DomainModel;
using System;

namespace MVCForum.Domain.Interfaces.Services
{
    public partial interface IEmailService
    {
        void SendMail(Email email, Settings settings);
        void SendMail(Email email);
        void SendMail(List<Email> email);
        void SendMail(List<Email> email, Settings settings);
        void ProcessMail(int amountToSend);
        string EmailTemplate(string to, string content);
        string EmailTemplateNewUser(string to, string content, Guid userId);

        string EmailTemplate(string to, string content, Settings settings);
        Email Add(Email email);
        void Delete(Email email);
        List<Email> GetAll(int amountToTake);
    }
}
