#!/bin/sh

#
#OTRS 6 (6.0.18)
#
#Usage:
# otrs.Console.pl command [options] [arguments]
#
#Options:
# [--help]                                 - Display help for this command.
# [--no-ansi]                              - Do not perform ANSI terminal output coloring.
# [--quiet]                                - Suppress informative output, only retain error messages.

#Available commands:
# Help                                     - Display help for an existing command or search for commands.
# List                                     - List available commands.
# Search                                   - Search for commands.
#Admin
# Admin::Article::StorageSwitch            - Migrate article files from one storage backend to another on the fly.
# Admin::CommunicationChannel::Drop        - Drop a communication channel (with its data) that is no longer available in the system.
# Admin::CommunicationChannel::Sync        - Synchronize registered communication channels in the system.
# Admin::Config::FixInvalid                - Attempt to fix invalid system configuration settings.
# Admin::Config::ListInvalid               - List invalid system configuration.
# Admin::Config::Read                      - Gather the value of a setting.
# Admin::Config::UnlockAll                 - Unlock all settings.
# Admin::Config::Update                    - Update the value of a setting.
# Admin::CustomerCompany::Add              - Add a customer company.
# Admin::CustomerUser::Add                 - Add a customer user.
# Admin::CustomerUser::SetPassword         - Update the password for a customer user.
# Admin::FAQ::Import                       - FAQ import tool.
# Admin::Group::Add                        - Create a new group.
# Admin::Group::CustomerLink               - Connect a customer user to a group.
# Admin::Group::RoleLink                   - Connect a role to a group.
# Admin::Group::UserLink                   - Connect a user to a group.
# Admin::Package::Export                   - Export the contents of an OTRS package to a directory.
# Admin::Package::FileSearch               - Find a file in an installed OTRS package.
# Admin::Package::Install                  - Install an OTRS package.
# Admin::Package::List                     - List all installed OTRS packages.
# Admin::Package::ListInstalledFiles       - List all installed OTRS package files.
# Admin::Package::Reinstall                - Reinstall an OTRS package.
# Admin::Package::ReinstallAll             - Reinstall all OTRS packages that are not correctly deployed.
# Admin::Package::RepositoryList           - List all known OTRS package repsitories.
# Admin::Package::Uninstall                - Uninstall an OTRS package.
# Admin::Package::Upgrade                  - Upgrade an OTRS package.
# Admin::Package::UpgradeAll               - Upgrade all OTRS packages to the latest versions from the on-line repositories.
# Admin::Queue::Add                        - Create a new queue.
# Admin::Queue::List                       - List existing queues.
# Admin::Role::Add                         - Create a new role.
# Admin::Role::UserLink                    - Connect a user to a role.
# Admin::Service::Add                      - Add new service.
# Admin::StandardTemplate::QueueLink       - Link a template to a queue.
# Admin::SystemAddress::Add                - Add new system address.
# Admin::TicketType::Add                   - Add new ticket type.
# Admin::User::Add                         - Add a user.
# Admin::User::SetPassword                 - Update the password for an agent.
# Admin::WebService::Add                   - Create a new web service.
# Admin::WebService::Delete                - Delete an existing web service.
# Admin::WebService::Dump                  - Print a web service configuration (in YAML format) into a file.
# Admin::WebService::List                  - List all web services.
# Admin::WebService::Update                - Update an existing web service.
#Dev
# Dev::Code::ContributorsListUpdate        - Update the list of contributors based on git commit information.
# Dev::Code::Generate::ConsoleCommand      - Generate a console command skeleton.
# Dev::Code::Generate::UnitTest::Backend   - Generate a test skeleton.
# Dev::Package::Build                      - Create an OTRS package (opm) file from an OTRS package source (sopm) file.
# Dev::Package::RepositoryIndex            - Generate an index file (otrs.xml) for an OTRS package repository.
# Dev::Tools::CacheBenchmark               - Run a benchmark over the available cache backends.
# Dev::Tools::Config2Docbook               - Generate a config options reference chapter (docbook) for the administration manual.
# Dev::Tools::ConsoleStats                 - Print some statistics about available console commands.
# Dev::Tools::ImportFakeEmails             - Insert fake emails/tickets to the system.
# Dev::Tools::RPMSpecGenerate              - Generate RPM spec files.
# Dev::Tools::Shell                        - An interactive REPL shell for the OTRS API.
# Dev::Tools::TestEmails                   - Get emails from test backend and output them to screen.
# Dev::Tools::TranslationsUpdate           - Update the OTRS translation files.
# Dev::Tools::Database::RandomDataInsert   - Insert random data into the OTRS database for testing purposes.
# Dev::Tools::Database::XML2SQL            - Convert OTRS database XML to SQL.
# Dev::Tools::Database::XMLExecute         - Convert an OTRS database XML file to SQL and execute it in the current database.
# Dev::Tools::GenericInterface::DebugRead  - Read parts of the generic interface debug log based on your given options.
# Dev::Tools::Migrate::ConfigXMLStructure  - Migrate XML configuration files from OTRS 5 to OTRS 6.
# Dev::Tools::Migrate::DTL2TT              - Migrate DTL files to Template::Toolkit.
# Dev::UnitTest::Run                       - Execute unit tests.
#Maint
# Maint::Cache::Delete                     - Delete cache files created by OTRS.
# Maint::CloudServices::ConnectionCheck    - Check OTRS cloud services connectivity.
# Maint::Config::Dump                      - Dump configuration settings.
# Maint::Config::Rebuild                   - Rebuild the system configuration of OTRS.
# Maint::Config::Sync                      - Synchronize system configuration file with the latest deployment in the database.
# Maint::Daemon::List                      - List available daemons.
# Maint::Daemon::Summary                   - Show a summary of one or all daemon modules.
# Maint::Database::Check                   - Check OTRS database connectivity.
# Maint::Database::PasswordCrypt           - Make a database password unreadable for inclusion in Kernel/Config.pm.
# Maint::Database::MySQL::InnoDBMigration  - Convert all MySQL database tables to InnoDB.
# Maint::Email::MailQueue                  - Mail queue management.
# Maint::FAQ::ContentTypeSet               - Sets the content type of FAQ items.
# Maint::FormDraft::Delete                 - Delete draft entries.
# Maint::GenericAgent::Run                 - Run all generic agent jobs from a configuration file.
# Maint::GenericInterface::DebugLog::Cleanup - Delete Generic Interface debug log entries.
# Maint::Loader::CacheCleanup              - Cleanup the CSS/JS loader cache.
# Maint::Loader::CacheGenerate             - Generate the CSS/JS loader cache.
# Maint::Log::Clear                        - Clear the OTRS log.
# Maint::Log::CommunicationLog             - Management of communication logs.
# Maint::Log::Print                        - Print the OTRS log.
# Maint::OTRSBusiness::AvailabilityCheck   - Check if OTRS Business Solution\x{2122} is available for the current system.
# Maint::OTRSBusiness::EntitlementCheck    - Check the OTRS Business Solution\x{2122} is entitled for this system.
# Maint::PostMaster::MailAccountFetch      - Fetch incoming emails from configured mail accounts.
# Maint::PostMaster::Read                  - Read incoming email from STDIN.
# Maint::PostMaster::SpoolMailsReprocess   - Reprocess mails from spool directory that could not be imported in the first place.
# Maint::Registration::UpdateSend          - Send an OTRS system registration update to OTRS Group.
# Maint::SMIME::FetchFromCustomer          - Refresh existing keys for new ones from the LDAP.
# Maint::SMIME::KeysRefresh                - Normalize S/MIME private secrets and rename all certificates to the correct hash.
# Maint::SMIME::CustomerCertificate::Fetch - Fetch S/MIME certificates from customer backends.
# Maint::SMIME::CustomerCertificate::Renew - Renew existing S/MIME certificates from customer backends.
# Maint::Session::DeleteAll                - Delete all sessions.
# Maint::Session::DeleteExpired            - Delete expired sessions.
# Maint::Session::ListAll                  - List all sessions.
# Maint::Session::ListExpired              - List expired sessions.
# Maint::Stats::Generate                   - Generate (and send, optional) statistics which have been configured previously in the OTRS statistics module.
# Maint::Stats::Dashboard::Generate        - Generate statistics widgets for the dashboard.
# Maint::SupportBundle::Generate           - Generate a support bundle for this system.
# Maint::SupportData::CollectAsynchronous  - Collect certain support data asynchronously.
# Maint::Survey::RequestsDelete            - Delete survey results (including vote data and requests).
# Maint::Survey::RequestsSend              - Send pending survey requests.
# Maint::Ticket::ArchiveCleanup            - Delete ticket/article seen flags and ticket watcher entries for archived tickets.
# Maint::Ticket::Delete                    - Delete one or more tickets.
# Maint::Ticket::Dump                      - Print a ticket and its articles to the console.
# Maint::Ticket::EscalationCheck           - Trigger ticket escalation events and notification events for escalation.
# Maint::Ticket::EscalationIndexRebuild    - Completely rebuild the ticket escalation index.
# Maint::Ticket::FulltextIndex             - Flag articles to automatically rebuild the article search index or displays the index status.
# Maint::Ticket::FulltextIndexRebuildWorker - Rebuild the article search index for needed articles.
# Maint::Ticket::InvalidUserCleanup        - Delete ticket/article seen flags and ticket watcher entries of users which have been invalid for more than a month, and unlocks tickets by invalid agents immedately.
# Maint::Ticket::PendingCheck              - Process pending tickets that are past their pending time and send pending reminders.
# Maint::Ticket::QueueIndexCleanup         - Cleanup unneeded entries from StaticDB queue index.
# Maint::Ticket::QueueIndexRebuild         - Rebuild the ticket index for AgentTicketQueue.
# Maint::Ticket::RestoreFromArchive        - Restore non-closed tickets from the ticket archive.
# Maint::Ticket::UnlockAll                 - Unlock all tickets by force.
# Maint::Ticket::UnlockTicket              - Unlock a single ticket by force.
# Maint::Ticket::UnlockTimeout             - Unlock tickets that are past their unlock timeout.
# Maint::WebUploadCache::Cleanup           - Cleanup the upload cache.
#

DEPARTMENTS="custos
financeiro
fiscal
marketing
recuros_humanos
sistemas_projetos
suporte_infraestrutura
suporte_sistemas
suprimentos"


# Group

for itemgroup in $DEPARTMENTS
do

    su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Group::Add --name group_${itemgroup}"

done


# Role


for itemrole in $DEPARTMENTS
do

    su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Role::Add --name role_${itemrole}"

done


# Queue -> Group


for itemqueue in $DEPARTMENTS
do

    su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Queue::Add --name queue_${itemqueue} --group group_${itemqueue}"

done


# Role -> Group


for itemrole in $DEPARTMENTS
do

    for other_department in $DEPARTMENTS
    do

        if [ "$itemrole" = "$other_department"  ]
        then

            su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Group::RoleLink --role-name role_${itemrole} --group-name group_${itemrole} --permission rw"

        else

            su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Group::RoleLink --role-name role_${itemrole} --group-name group_${other_department} --permission move_into"

        fi

    done

done

# Services

for service in $DEPARTMENTS
do

    su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Service::Add --name ${service} --comment ${service}"

    for i in `seq 1 5`
    do

        su otrs -s /bin/bash -c "/opt/otrs/bin/otrs.Console.pl Admin::Service::Add --name subservice_${service}_${i} --parent-name ${service} --comment subservice_${service}_${i}"

    done

done




